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
            TableRelation = Bicycle."No";

            trigger OnValidate()
            var
                Bicycle: Record Bicycle;
                RentalHeader: Record "Rental Header";
                RentalType: Record "Rental Type";
                RentalPrice: Record RentalPriceCenik;
            begin
                if "Bicycle No." = '' then begin
                    Description := '';
                    "Daily Rate" := 0;
                    CalcLineAmount();
                    exit;
                end;


                if not RentalHeader.Get("Rental No.") then
                    Error('Za vrstico izposoje %1 ne obstaja glava izposoje.', "Rental No.");


                if not Bicycle.Get("Bicycle No.") then
                    Error('Kolo %1 ne obstaja v sistemu.', "Bicycle No.");


                if Bicycle."Rental Type Code" = '' then
                    Error('Kolo %1 nima določenega tipa kolesa.', "Bicycle No.");


                if Bicycle.Status <> Bicycle.Status::Available then
                    Error('Kolo %1 ni na voljo za izposojo.', "Bicycle No.");


                Description := Bicycle.Description;


                RentalPrice.SetRange("Rental Type Code", Bicycle."Rental Type Code");
                RentalPrice.SetFilter("Starting date", '<=%1', RentalHeader."Rental Date");
                RentalPrice.SetFilter("Ending date", '>=%1', RentalHeader."Rental Date");

                if RentalPrice.FindFirst() then
                    "Daily Rate" := RentalPrice."Daily rate"
                else begin

                    if not RentalType.Get(Bicycle."Rental Type Code") then
                        Error('Za tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena.', Bicycle."Rental Type Code");
                    if RentalType."Daily Rate" = 0 then
                        Error('Za tip kolesa %1 ne obstaja niti veljaven cenik niti osnovna cena.', Bicycle."Rental Type Code");
                    "Daily Rate" := RentalType."Daily Rate";
                end;

                CalcLineAmount();
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
    procedure CalcLineAmount()
    begin
        "Line Amount" := "Daily Rate" * "Rental Days";
    end;
}