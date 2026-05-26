table 50113 "Rental Line"
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
            TableRelation = Bicycle.No;

            trigger OnValidate()
            var
                Bicycle: Record Bicycle;
                RentalType: Record "Rental Type";
            begin
                if Bicycle.Get("Bicycle No.") then begin
                    if Bicycle.Status <> Bicycle.Status::Available then
                        Error('Kolesa %1 ni mogoče izbrati, ker nima statusa Available.', "Bicycle No.");

                    Bicycle.CalcFields(Description);
                    Description := Bicycle.Description;

                    if RentalType.Get(Bicycle."Rental Type Code") then
                        "Daily Rate" := RentalType."Daily Rate";

                    if "Rental Days" > 0 then
                        "Line Amount" := "Daily Rate" * "Rental Days";
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
                "Line Amount" := "Daily Rate" * "Rental Days";
            end;
        }
        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                if "Rental Days" <= 0 then
                    Error('Rental Days mora biti večji od 0.');

                "Line Amount" := "Daily Rate" * "Rental Days";
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
}