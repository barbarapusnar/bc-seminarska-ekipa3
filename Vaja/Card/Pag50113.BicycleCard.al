namespace bcseminarskaekipa.bcseminarskaekipa;

page 50113 "Bicycle Card"
{
    ApplicationArea = All;
    Caption = 'Bicycle Card';
    PageType = Card;
    SourceTable = Bicycle;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Rental Type Code"; Rec."Rental Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rental Type Code field.', Comment = '%';
                    LookupPageId = "Rental Type Page";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            group(Advance)
            {
                Caption = 'Details';
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Date field.', Comment = '%';
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Price field.', Comment = '%';
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Location field.', Comment = '%';
                }
                field("Last Service Date"; Rec."Last Service Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Service Date field.', Comment = '%';
                }
            }
        }
    }
}
