namespace bcseminarskaekipa.bcseminarskaekipa;
xmlport 50110 "XMLport"
{
    Caption = 'XMLport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Bicycle; Bicycle)
            {
                fieldelement(No; Bicycle.No)
                {
                }
                fieldelement(RentalTypeCode; Bicycle."Rental Type Code")
                {
                }
                fieldelement(Description; Bicycle.Description)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
