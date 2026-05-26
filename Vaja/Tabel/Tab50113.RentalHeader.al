table 50113 "Rental Header"
{
    Caption = 'Rental Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[100])
        {
            Caption = 'Customer No.';

            trigger OnValidate()
            begin
                if "Customer No." = '' then
                    Error('Customer No. must not be empty.');
            end;
        }
        field(3; "Rental Date"; Date)
        {
            Caption = 'Rental Date';

            trigger OnValidate()
            begin
                if ("Expected Return Date" <> 0D) and ("Expected Return Date" < "Rental Date") then
                    Error('Expected Return Date must not be earlier than Rental Date.');
            end;
        }
        field(4; "Expected Return Date"; Date)
        {
            Caption = 'Expected Return Date';

            trigger OnValidate()
            begin
                if ("Expected Return Date" <> 0D) and ("Expected Return Date" < "Rental Date") then
                    Error('Expected Return Date must not be earlier than Rental Date.');
            end;
        }
        field(5; "Actual Return Date"; Date)
        {
            Caption = 'Actual Return Date';
        }
        field(6; Status; Enum "Rental Status")
        {
            Caption = 'Status';
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Rental Line"."Line Amount" where("Rental No." = field("No.")));
            Editable = false;
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
