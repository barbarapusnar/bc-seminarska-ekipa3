table 50110 "Rental Type"
{
    Caption = 'Rental Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0.01;

        }
        field(4; "Max Rental Days"; Integer)
        {
            Caption = 'Max Rental Days';
            MinValue = 1;
        }
        field(5; "Requires Deposit"; Boolean)
        {
            Caption = 'Requires Deposit';
        }
        field(6; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
            trigger OnValidate()
            begin

            end;
        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
