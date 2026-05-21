table 50110 "Rental Type"
{
    Caption = 'Rental Type';
    LookupPageId = "Rental Type Page";
    DrillDownPageId = "Rental Type Page";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

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
                if "Requires Deposit" and ("Deposit Amount" <= 0) then
                    Error('Depozit mora biti vecje od 0, če je Depozit potreben');
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
