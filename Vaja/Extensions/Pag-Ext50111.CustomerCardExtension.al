namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Customer;

pageextension 50111 "Customer Card Rental Ext" extends 21
{
    layout
    {
        addafter(General)
        {
            group("Rental Information")
            {
                Caption = 'Rental Information';

                field("Preferred Rental Type"; Rec."Preferred Rental Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the preferred rental type for this customer.';
                }
                field("VIP Customer"; Rec."VIP Customer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this customer is a VIP customer.';
                }
                field("Max Active Rentals"; Rec."Max Active Rentals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of active rentals for this customer.';
                }
            }
        }
    }
}