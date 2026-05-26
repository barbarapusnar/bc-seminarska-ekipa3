table 50113 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rental No."; Code[100])
        {
            Caption = 'Rental No.';
        }
        field(2; "Line No."; Code[100])
        {
            Caption = 'Line No.';
        }
        field(3; "Bicycle No."; Code[100])
        {
            Caption = 'Bicycle No.';
            TableRelation = Bicycle."No" WHERE(Status = CONST(Available));


            trigger OnValidate()
            var
                BicycleRec: Record Bicycle;
            begin
                if BicycleRec.Get("Bicycle No.") then begin
                    Description := BicycleRec.Description;
                end;
            end;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }

        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                UpdateLineAmount();
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
        key(PK; "Rental No.")
        {
            Clustered = true;
        }
    }
    local procedure UpdateLineAmount()
    begin
        "Line Amount" := "Daily Rate" * "Rental Days";
    end;
}
