namespace bcseminarskaekipa.bcseminarskaekipa;

xmlport 50110 "Import Bicycles"
{
    Caption = 'Import Bicycles';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(Bicycles)
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
                    // Preveri ali tip kolesa obstaja
                    if not RentalType.Get(Bicycle."Rental Type Code") then begin
                        currXMLport.Skip();  // Preskoči neveljaven zapis
                        exit;
                    end;

                    // Preveri ali zapis že obstaja
                    if Bicycle.Find() then begin
                        currXMLport.Skip();  // Preskoči duplikat
                        exit;
                    end;
                end;
            }
        }
    }
}