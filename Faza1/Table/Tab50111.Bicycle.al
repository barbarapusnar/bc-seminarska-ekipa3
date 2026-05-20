table 50111 Bicycle
{
    Caption = 'Bicycle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
        }
        field(2; "Rental Type Code"; Code[100])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
            TableRelation = "Rental Type".Code;

            trigger OnValidate()
            var
                RentalType: Record "Rental Type";
            begin
                ;

                if RentalType.Get("Rental Type Code") then
                    Description := RentalType.Description
                else
                    Description := '';
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; Status; Enum "Bicycle Status")
        {
            Caption = 'Status';
            InitValue = Available;
        }
        field(5; "Purchase Date"; Date)
        {
            Caption = 'Purchase Date';
        }
        field(6; "Purchase Price"; Decimal)
        {
            Caption = 'Purchase Price';
            MinValue = 0.01;
            trigger OnValidate()
            begin
                ;

                if "Purchase Price" < 0 then
                    Error('Cena ne more biti negativna');
            end;
        }
        field(7; "Current Location"; Text[150])
        {
            Caption = 'Current Location';
        }
        field(8; "Last Service Date"; Date)
        {
            Caption = 'Last Service Date';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
