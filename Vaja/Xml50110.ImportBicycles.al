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
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;

                fieldelement(No; Bicycle.No)
                {
                    XmlName = 'No';
                }

                // ✅ Rental Type Code kot textelement — ne gre skozi TableRelation validacijo
                textelement(RentalTypeCode)
                {
                    XmlName = 'RentalTypeCode';

                    trigger OnAfterAssignVariable()
                    begin
                        Bicycle."Rental Type Code" := CopyStr(RentalTypeCode, 1, 20);
                    end;
                }

                trigger OnBeforeInsertRecord()
                var
                    RentalType: Record "Rental Type";
                begin
                    // ✅ Preveri ali tip kolesa obstaja
                    if not RentalType.Get(Bicycle."Rental Type Code") then begin
                        currXMLport.Skip();
                        exit;
                    end;

                    // ✅ Preveri ali zapis že obstaja
                    if Bicycle.Find() then begin
                        currXMLport.Skip();
                        exit;
                    end;

                    // ✅ Ročno vstavi
                    Bicycle.Insert(true);
                end;
            }
        }
    }
}