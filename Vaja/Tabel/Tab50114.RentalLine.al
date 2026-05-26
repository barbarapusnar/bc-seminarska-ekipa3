table 50114 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rental No."; Code[20])
        {
            Caption = 'Rental No.';
            TableRelation = "Rental Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bicycle No."; Code[20])
        {
            Caption = 'Bicycle No.';
            TableRelation = Bicycle."No";

            trigger OnValidate()
            var
                Bicycle: Record Bicycle;
                RentalHeader: Record "Rental Header";
                RentalType: Record "Rental Type";
            begin
                if "Bicycle No." <> '' then begin
                    // Fetch bicycle and validate status
                    Bicycle.Get("Bicycle No.");
                    if Bicycle.Status <> Bicycle.Status::Available then
                        Error('Bicycle %1 is not available for rental.', "Bicycle No.");

                    // Auto-transfer description
                    Description := Bicycle.Description;

                    // Get Daily Rate from RentalType linked to the Bicycle
                    if RentalHeader.Get("Rental No.") then
                        if RentalType.Get(Bicycle."Rental Type Code") then
                            "Daily Rate" := RentalType."Daily Rate";

                    CalcLineAmount();
                end else begin
                    Description := '';
                    "Daily Rate" := 0;
                    CalcLineAmount();
                end;
            end;
        }
        field(4; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0;

            trigger OnValidate()
            begin
                CalcLineAmount();
            end;
        }
        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                if "Rental Days" <= 0 then
                    Error('Rental Days must be greater than 0.');
                CalcLineAmount();
            end;
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Rental No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure CalcLineAmount()
    begin
        "Line Amount" := "Daily Rate" * "Rental Days";
    end;
}