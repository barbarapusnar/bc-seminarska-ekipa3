page 50119 "Bicycle API"
{
    PageType = API;

    APIPublisher = 'ekipa';
    APIGroup = 'rental';
    APIVersion = 'v1.0';

    EntityName = 'bicycle';
    EntitySetName = 'bicycles';

    SourceTable = Bicycle;

    ODataKeyFields = SystemId;

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
                }

                field(description; Rec.Description)
                {
                }

                field(status; Rec.Status)
                {
                }

                field(rentalTypeCode; Rec."Rental Type Code")
                {
                }
            }
        }
    }
}