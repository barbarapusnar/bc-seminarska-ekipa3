table 50111 Bicycle
{
    Caption = 'Bicycle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            NotBlank = true;
        }
        field(2; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
            TableRelation = "Rental Type".Code;
            trigger OnValidate()
            var
                RentalType: Record "Rental Type";
            begin
                if RentalType.Get("Rental Type Code") then Description := RentalType.Description;
            end;
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
            // Naredi LOOKUP za to
            //FieldClass = FlowField;
            //CalcFormula = lookup();
        }
        field(4; "Status"; Enum "Bicycle Status")
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
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
