namespace bcseminarskaekipa.bcseminarskaekipa;

table 50114 "Rental Price List"
{
    Caption = 'Rental Price List';
    DataClassification = ToBeClassified;
    LookupPageId = "Rental Price List";
    DrillDownPageId = "Rental Price List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
            TableRelation = "Rental Type".Code;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                ValidateDates();
                CheckOverlap();
            end;
        }
        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                ValidateDates();
                CheckOverlap();
            end;
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(RentalTypeDate; "Rental Type Code", "Starting Date", "Ending Date") { }
    }

    local procedure ValidateDates()
    begin
        if ("Starting Date" <> 0D) and ("Ending Date" <> 0D) then
            if "Starting Date" > "Ending Date" then
                Error('Starting Date mora biti manjši ali enak Ending Date.');
    end;

    local procedure CheckOverlap()
    var
        RentalPriceList: Record "Rental Price List";
    begin
        if ("Rental Type Code" = '') or ("Starting Date" = 0D) or ("Ending Date" = 0D) then
            exit;

        RentalPriceList.SetRange("Rental Type Code", "Rental Type Code");
        RentalPriceList.SetFilter(Code, '<>%1', Code);
        RentalPriceList.SetFilter("Starting Date", '<=%1', "Ending Date");
        RentalPriceList.SetFilter("Ending Date", '>=%1', "Starting Date");

        if not RentalPriceList.IsEmpty() then
            Error('Za tip kolesa %1 že obstaja veljaven cenik v tem časovnem obdobju.', "Rental Type Code");
    end;
}