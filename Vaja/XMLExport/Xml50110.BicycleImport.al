namespace bcseminarskaekipa.bcseminarskaekipa;

xmlport 50110 "Bicycle Import"
{
    Caption = 'Bicycle Import';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(root)
        {
            tableelement(Bicycle; Bicycle)
            {
                XmlName = 'Bicycle';
                fieldelement(No; Bicycle.No)
                {
                    XmlName = 'No';
                }
                fieldelement(RentalTypeCode; Bicycle."Rental Type Code")
                {
                    XmlName = 'RentalTypeCode';
                }
                fieldelement(Description; Bicycle.Description)
                {
                    XmlName = 'Description';
                }

                trigger OnBeforeInsertRecord()
                var
                    RentalType: Record "Rental Type";
                begin
                    // Preveri da tip kolesa obstaja
                    if not RentalType.Get(Bicycle."Rental Type Code") then begin
                        currXMLport.Skip();
                        exit;
                    end;

                    // Preveri da kolo s to številko še ne obstaja
                    if Bicycle.Find() then begin
                        currXMLport.Skip();
                        exit;
                    end;
                end;
            }
        }
    }
}