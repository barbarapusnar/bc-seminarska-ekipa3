table 50114 RentalPriceCenik
{
    Caption = 'RentalPriceList';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
            TableRelation = "Rental Type".Code;
        }
        field(4; "Starting date"; Date)
        {
            Caption = 'Starting date';
            trigger OnValidate()
            begin
                if "Ending date" < "Starting date" then
                    Error('Ending date must be later or equal to Starting date.');
            end;

        }
        field(5; "Ending date"; Date)
        {
            Caption = 'Ending date';
        }
        field(6; "Daily rate"; Decimal)
        {
            Caption = 'Daily rate';
            MinValue = 0.1;
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
