table 50113 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rental No."; Code[100])
        {
            Caption = 'Rental No.';
            TableRelation = "Rental Header"."No.";
        }
        field(2; "Line No."; Code[100])
        {
            Caption = 'Line No.';
        }
        field(3; "Bicycle No."; Code[100])
        {
            Caption = 'Bicycle No.';
            TableRelation = Bicycle."No.";

            trigger OnValidate()
            var
                Bicycle: Record Bicycle;
            begin
                if "Bicycle No." <> '' then begin
                    Bicycle.Get("Bicycle No.");
                    if Bicycle.Status <> Bicycle.Status::Available then
                        Error('Bicycle %1 is not available for rental.', "Bicycle No.");
                    Description := Bicycle.Description;
                    "Daily Rate" := Bicycle."Daily Rate";
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
