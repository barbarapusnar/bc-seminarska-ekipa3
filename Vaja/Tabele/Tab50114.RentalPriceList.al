table 50114 "Rental Price List"
{
    Caption = 'Rental Price List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            NotBlank = true;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            trigger onValidate()
            begin
                if (Rec."Starting Date" <= Rec."Ending Date") then
                    Error('Začetni datum izposoje ne smo bit enak ali večji od Končnega.');
            end;
        }

        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            trigger onValidate()
            begin
                if ("Daily Rate" < 0) then
                    Error('Cena na dan ne sme bit manjša od 0.');
            end;

        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    local procedure CheckDateOverlap()
    var
        RentalPriceList: Record "Rental Price List";
    begin
        RentalPriceList.Reset();
        RentalPriceList.SetRange("Rental Type Code", "Rental Type Code");

        // Izloči trenutni zapis pri spreminjanju
        RentalPriceList.SetFilter(Code, '<>%1', Code);

        RentalPriceList.SetFilter(
            "Starting Date",
            '<=%1',
            "Ending Date");

        RentalPriceList.SetFilter(
            "Ending Date",
            '>=%1',
            "Starting Date");

        if RentalPriceList.FindFirst() then
            Error(
              'For rental type %1 a valid price list already exists in the selected period.',
              "Rental Type Code");
    end;
}
