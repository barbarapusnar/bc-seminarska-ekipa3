namespace bcseminarskaekipa.bcseminarskaekipa;

page 50114 "Rental List"
{
    ApplicationArea = All;
    Caption = 'Rental List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Rental Header";
    CardPageId = "Rental Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rental number.';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }

                field("Rental Date"; Rec."Rental Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rental date.';
                }

                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected return date.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the rental.';
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the rental.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PrintRentalReport)
            {
                Caption = 'Print Rental Report';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Prints the rental report by customer.';

                trigger OnAction()
                begin
                    Report.RunModal(50120, true, true);
                end;
            }
        }
    }
}