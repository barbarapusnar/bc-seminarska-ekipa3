namespace bcseminarskaekipa.bcseminarskaekipa;

page 50115 "Rental Card"
{
    ApplicationArea = All;
    Caption = 'Rental Card';
    PageType = Document;
    UsageCategory = None;
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Rental Date"; Rec."Rental Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental Date field.', Comment = '%';
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Return Date field.', Comment = '%';
                }
                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Return Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
            }
            part(RentalLines; "Rental Line Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Rental No." = field("No.");
                Caption = 'Rental Lines';
            }
        }
    }
}
