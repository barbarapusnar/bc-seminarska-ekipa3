namespace bcseminarskaekipa.bcseminarskaekipa;

using Microsoft.Sales.Customer;

pageextension 50111 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group("Rental Information")
            {
                field("Preferred Rental Type"; Rec."Preferred Rental Type") { }
                field("VIP Customer"; Rec."VIP Customer") { }
                field("Max Active Rentals"; Rec."Max Active Rentals") { }
            }
        }
    }
}
