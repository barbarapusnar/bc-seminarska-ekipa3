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
            begin
                if Bicycle.Get("Bicycle No.") then begin
                    if Bicycle.Status <> Bicycle.Status::Available then
                        Error('Kolesa %1 ni mogoče izbrati, ker nima statusa Available.', "Bicycle No.");

                    Bicycle.CalcFields(Description);
                    Description := Bicycle.Description;

                    if RentalType.Get(Bicycle."Rental Type Code") then
                        "Daily Rate" := RentalType."Daily Rate";

                    if "Rental Days" > 0 then
                        "Line Amount" := "Daily Rate" * "Rental Days";
                end;
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
    local procedure UpdateRentalPrice()
    var
        RentalHeader: Record "Rental Header";
        Bike: Record Bicycle;
        RentalType: Record "Rental Type";
        RentalPriceList: Record "Rental Price List";
    begin

        // 1. Header
        if not RentalHeader.Get("Rental No.") then
            Error('Rental Header does not exist.');

        // 2. Bike
        if not Bike.Get("Bicycle No.") then
            Error('Selected bike cannot be found.');

        // 3. Rental Type
        if Bike."Rental Type Code" = '' then
            Error('Selected bike does not have a rental type.');

        // 4. Price List
        RentalPriceList.Reset();
        RentalPriceList.SetRange("Rental Type Code", Bike."Rental Type Code");
        RentalPriceList.SetFilter("Starting Date", '<=%1', RentalHeader."Rental Date");
        RentalPriceList.SetFilter("Ending Date", '>=%1', RentalHeader."Rental Date");

        if RentalPriceList.FindFirst() then begin
            "Daily Rate" := RentalPriceList."Daily Rate";
        end else begin

            // 5. Fallback na Rental Type
            if not RentalType.Get(Bike."Rental Type Code") then
                Error('Rental Type %1 does not exist.', Bike."Rental Type Code");

            if RentalType."Daily Rate" <= 0 then
                Error(
                  'No valid price list and no base price exists for rental type %1.',
                  Bike."Rental Type Code");

            "Daily Rate" := RentalType."Daily Rate";
        end;

        // 6. Recalculate amount
        "Line Amount" := "Rental Days" * "Daily Rate";
    end;
}