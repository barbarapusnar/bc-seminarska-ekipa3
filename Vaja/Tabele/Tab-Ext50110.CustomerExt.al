namespace bcseminarskaekipa.bcseminarskaekipa;

using Microsoft.Sales.Customer;

tableextension 50110 "Customer Ext" extends Customer
{
    fields
    {
        field(50110; "Preferred Rental Type"; Code[20])
        {
            Caption = 'Preferred Rental Type';
            DataClassification = ToBeClassified;
            TableRelation = "Rental Type".Code;
        }

        field(50111; "VIP Customer"; Boolean)
        {
            Caption = 'VIP Customer';
            DataClassification = ToBeClassified;
        }

        field(50112; "Max Active Rentals"; Integer)
        {
            Caption = 'Max Active Rentals';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Max Active Rentals" < 0 then
                    Error('Max Active Rentals must be greater than or equal to 0.');
            end;
        }
    }
}