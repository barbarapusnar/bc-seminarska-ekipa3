namespace bcseminarskaekipa.bcseminarskaekipa;

page 50114 "Rental List"
{
    ApplicationArea = All;
    Caption = 'Rental List';
    PageType = List;
    SourceTable = "Rental Header";
    UsageCategory = Lists;
    CardPageId = "Rental Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
        }
    }

    actions
    {
        area(Processing)
        {
            action(PrintRentalAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Pregled izposoj';
                ToolTip = 'Odpre poročilo s pregledom izposoj po strankah.';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    Report.RunModal(Report::ReportAnalysis);
                end;
            }
        }
    }
}