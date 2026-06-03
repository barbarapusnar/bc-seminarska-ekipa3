namespace bcseminarskaekipa.bcseminarskaekipa;

page 50117 "Rental Price List"
{
    ApplicationArea = All;
    Caption = 'Rental Price List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Rental Price List";
    CardPageId = "Rental Price Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price list code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rental type code.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending date.';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the daily rate.';
                }
            }
        }
    }
}