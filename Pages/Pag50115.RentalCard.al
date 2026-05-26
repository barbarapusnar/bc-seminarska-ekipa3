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

                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ToolTip = 'Specifies the value of the Actual Return Date field.', Comment = '%';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }

                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ToolTip = 'Specifies the value of the Expected Return Date field.', Comment = '%';
                }

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }

                field("Rental Date"; Rec."Rental Date")
                {
                    ToolTip = 'Specifies the value of the Rental Date field.', Comment = '%';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
            }

            part(Lines; "Rental Line Subpage")
            {
                ToolTip = 'Rental lines for this rental document.', Comment = '%';
                SubPageLink = "Rental No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(StartRental)
            {
                trigger OnAction()
                var
                    RM: Codeunit "Rental Management";
                begin
                    RM.StartRental(Rec);
                end;
            }

            action(ProcessReturn)
            {
                trigger OnAction()
                var
                    RM: Codeunit "Rental Management";
                begin
                    RM.ProcessReturn(Rec);
                end;
            }
        }
    }
}