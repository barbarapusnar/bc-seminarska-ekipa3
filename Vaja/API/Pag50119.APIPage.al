namespace bcseminarskaekipa.bcseminarskaekipa;

page 50119 "API Page"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiPage';
    DelayedInsert = true;
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    PageType = API;
    SourceTable = Bicycle;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(rentalTypeCode; Rec."Rental Type Code")
                {
                    Caption = 'Rental Type Code';
                }
            }
        }
    }
}
