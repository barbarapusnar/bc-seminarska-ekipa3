page 50116 "Rental Line Subpage"
{
    ApplicationArea = All;
    Caption = 'Rental Lines';
    PageType = ListPart;
    SourceTable = "Rental Line";
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the line number.';
                    ApplicationArea = All;
                }
                field("Bicycle No."; Rec."Bicycle No.")
                {
                    ToolTip = 'Specifies the bicycle number.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the bicycle description.';
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ToolTip = 'Specifies the daily rental rate.';
                    ApplicationArea = All;
                }
                field("Rental Days"; Rec."Rental Days")
                {
                    ToolTip = 'Specifies the number of rental days.';
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the total line amount.';
                    ApplicationArea = All;
                }
            }
        }
    }
}