namespace bcseminarskaekipa.bcseminarskaekipa;

page 50116 "Rental Line Subpage"
{
    ApplicationArea = All;
    Caption = 'Rental Lines';
    PageType = ListPart;
    SourceTable = "Rental Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Rental No."; Rec."Rental No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental No. field.', Comment = '%';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Bicycle No."; Rec."Bicycle No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bicycle No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Daily Rate field.', Comment = '%';
                }
                field("Rental Days"; Rec."Rental Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental Days field.', Comment = '%';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Amount field.', Comment = '%';
                }
            }
        }
    }
}
