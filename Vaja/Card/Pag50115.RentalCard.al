namespace bcseminarskaekipa.bcseminarskaekipa;

page 50115 "Rental Card"
{
    ApplicationArea = All;
    Caption = 'Rental Card';
    PageType = Card;
    SourceTable = "Rental Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the rental number.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number.';
                    ApplicationArea = All;
                }
                field("Rental Date"; Rec."Rental Date")
                {
                    ToolTip = 'Specifies the rental start date.';
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ToolTip = 'Specifies the expected return date.';
                    ApplicationArea = All;
                }
                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ToolTip = 'Specifies the actual return date.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the rental status.';
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the total rental amount.';
                    ApplicationArea = All;
                }
            }
            part(RentalLines; "Rental Line Subpage")
            {
                Caption = 'Rental Lines';
                ApplicationArea = All;
                SubPageLink = "Rental No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(StartRental)
            {
                ApplicationArea = All;
                Caption = 'Start Rental';
                ToolTip = 'Starts the rental. Sets all bicycles to Rented and changes status to Active.';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.StartRental(Rec);
                end;
            }
            action(ProcessReturn)
            {
                ApplicationArea = All;
                Caption = 'Process Return';
                ToolTip = 'Processes the return. Sets all bicycles back to Available, sets the actual return date, and changes status to Returned.';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.ProcessReturn(Rec);
                end;
            }
        }
    }
}