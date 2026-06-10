namespace bcseminarskaekipa.bcseminarskaekipa;

page 50119 "Bicycle API"
{
    PageType = API;
    Caption = 'Bicycle API';
    APIPublisher = 'bcseminarskaekipa';
    APIGroup = 'rental';
    APIVersion = 'v1.0';
    EntityName = 'bicycle';
    EntitySetName = 'bicycles';
    SourceTable = Bicycle;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec.No)
                {
                    Caption = 'No.';
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
                    Caption = 'Rental Type';
                }
            }
        }
    }
}