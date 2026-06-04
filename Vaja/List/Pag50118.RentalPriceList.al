namespace bcseminarskaekipa.bcseminarskaekipa;

page 50118 RentalPriceList
{
    ApplicationArea = All;
    Caption = 'RentalPriceList';
    PageType = List;
    SourceTable = RentalPriceCenik;
    UsageCategory = Lists;
    CardPageId = RentalPriceCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Daily rate"; Rec."Daily rate")
                {
                    ToolTip = 'Specifies the value of the Daily rate field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Ending date"; Rec."Ending date")
                {
                    ToolTip = 'Specifies the value of the Ending date field.', Comment = '%';
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ToolTip = 'Specifies the value of the Rental Type Code field.', Comment = '%';
                }
                field("Starting date"; Rec."Starting date")
                {
                    ToolTip = 'Specifies the value of the Starting date field.', Comment = '%';
                }
            }
        }
    }
}
