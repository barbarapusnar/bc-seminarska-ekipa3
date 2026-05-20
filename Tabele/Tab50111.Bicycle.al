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
        }
        field(3; Description; Text[200])
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
            trigger OnValidate()
            begin
                if "Purchase Price" <= 0 then
                    Error('Nakupna cena mora biti večja od 0.');
            end;
        }
        field(7; "Current Location"; Text[200])
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
