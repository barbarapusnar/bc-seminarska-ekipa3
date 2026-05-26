namespace bcseminarskaekipa.bcseminarskaekipa;

page 50110 "Rental Type Page"
{
    ApplicationArea = All;
    Caption = 'Rental Type Page';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Rental Type";
    CardPageId = "Rental Type Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                    ApplicationArea = All;
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
                field("Max Rental Days"; Rec."Max Rental Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Rental Days field.', Comment = '%';
                }

                field("Requires Deposit"; Rec."Requires Deposit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requires Deposit field.', Comment = '%';
                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Amount field.', Comment = '%';
                }
            }
        }
    }
}
