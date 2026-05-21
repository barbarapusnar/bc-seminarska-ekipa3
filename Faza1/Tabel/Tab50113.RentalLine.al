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
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
        }
        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
    }
    keys
    {
        key(PK; "Rental No.")
        {
            Clustered = true;
        }
    }
}
