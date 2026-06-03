table 50114 "Rental Price List"
{
    Caption = 'Rental Price List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            notEmpty = true;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            notEmpty = true;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            onValidate(){
                if (Rec."Starting Date" <= Rec."Ending Date") then
                    Error('Starting Date must be earlier than Ending Date.');
        }
    }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
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
