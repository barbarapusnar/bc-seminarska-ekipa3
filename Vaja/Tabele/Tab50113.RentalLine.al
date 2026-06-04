table 50113 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Rental No."; Code[20])
        {
            Caption = 'Rental No.';
            TableRelation = "Rental Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bicycle No."; Code[20])
        {
            Caption = 'Bicycle No.';
            TableRelation = Bicycle.No;

            trigger OnValidate()
            var
                Bicycle: Record Bicycle;
                RentalType: Record "Rental Type";
                RentalHeader: Record "Rental Header";
                RentalPriceList: Record "Rental Price List";
                RentalDate: Date;
            begin
                // Preveri ali obstaja glava izposoje
                if not RentalHeader.Get("Rental No.") then
                    Error('Za izbrano vrstico ne obstaja glava izposoje.');

                RentalDate := RentalHeader."Rental Date";

                // Preveri ali kolo obstaja
                if not Bicycle.Get("Bicycle No.") then
                    Error('Izbranega kolesa ni mogoče najti.');

                // Preveri status kolesa
                if Bicycle.Status <> Bicycle.Status::Available then
                    Error('Kolesa %1 ni mogoče izbrati, ker nima statusa Available.', "Bicycle No.");

                // Preveri ali ima kolo tip
                if Bicycle."Rental Type Code" = '' then
                    Error('Izbrano kolo nima določenega tipa kolesa.');

                // Prenesi opis
                Bicycle.CalcFields(Description);
                Description := Bicycle.Description;

                // Poišči cenik
                RentalPriceList.SetRange("Rental Type Code", Bicycle."Rental Type Code");
                RentalPriceList.SetFilter("Starting Date", '<=%1', RentalDate);
                RentalPriceList.SetFilter("Ending Date", '>=%1', RentalDate);

                if RentalPriceList.FindFirst() then
                    // Cena iz cenika
                    "Daily Rate" := RentalPriceList."Daily Rate"
                else begin
                    // Osnovna cena iz Rental Type
                    if RentalType.Get(Bicycle."Rental Type Code") then begin
                        if RentalType."Daily Rate" = 0 then
                            Error('Za tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena.', Bicycle."Rental Type Code");
                        "Daily Rate" := RentalType."Daily Rate";
                    end else
                        Error('Za tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena.', Bicycle."Rental Type Code");
                end;

                // Izračunaj Line Amount
                if "Rental Days" > 0 then
                    "Line Amount" := "Daily Rate" * "Rental Days";
            end;
        }
        field(4; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';

            trigger OnValidate()
            begin
                "Line Amount" := "Daily Rate" * "Rental Days";
            end;
        }
        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                if "Rental Days" <= 0 then
                    Error('Rental Days mora biti večji od 0.');

                "Line Amount" := "Daily Rate" * "Rental Days";
            end;
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Rental No.", "Line No.")
        {
            Clustered = true;
        }
    }
}