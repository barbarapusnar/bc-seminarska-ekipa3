namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Document;
codeunit 50110 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin

        if RentalHeader.Status <> RentalHeader.Status::Open then
            Error('Izposoja mora imeti status Open, da jo lahko začnete.');


        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Izposoja ne vsebuje nobene vrstice.');


        RentalLine.FindSet();
        repeat
            if Bicycle.Get(RentalLine."Bicycle No.") then begin
                if Bicycle.Status <> Bicycle.Status::Available then
                    Error('Kolo %1 ni na voljo (Status = Available).', RentalLine."Bicycle No.");
            end;
        until RentalLine.Next() = 0;


        RentalLine.FindSet();
        repeat
            if Bicycle.Get(RentalLine."Bicycle No.") then begin
                Bicycle.Status := Bicycle.Status::Rented;
                Bicycle.Modify();
            end;
        until RentalLine.Next() = 0;


        RentalHeader.Status := RentalHeader.Status::Active;
        RentalHeader.Modify();
    end;

    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin

        if RentalHeader.Status <> RentalHeader.Status::Active then
            Error('Izposoja mora imeti status Active, da jo lahko zaključite.');


        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Izposoja ne vsebuje nobene vrstice.');


        RentalLine.FindSet();
        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja v sistemu.', RentalLine."Bicycle No.");
        until RentalLine.Next() = 0;


        RentalLine.FindSet();
        repeat
            if Bicycle.Get(RentalLine."Bicycle No.") then begin
                Bicycle.Status := Bicycle.Status::Available;
                Bicycle.Modify();
            end;
        until RentalLine.Next() = 0;


        RentalHeader."Actual Return Date" := Today;
        RentalHeader.Status := RentalHeader.Status::Returned;
        RentalHeader.Modify();
    end;

    procedure CreateSalesInvoice(var RentalHeader: Record "Rental Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RentalLine: Record "Rental Line";
        LineNo: Integer;
    begin
        //  (Returned)
        if RentalHeader.Status <> RentalHeader.Status::Returned then
            Error('Prodajni dokument je mogoče ustvariti samo za zaključeno izposojo (status Returned).');

        // Preveri da stranka obstaja
        if RentalHeader."Customer No." = '' then
            Error('Izposoja nima določene stranke.');

        // Preveri da obstajajo vrstice
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Izposoja ne vsebuje nobene vrstice.');

        // Ustvari Sales Header (glavo računa)
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);

        SalesHeader."Sell-to Customer No." := RentalHeader."Customer No.";
        SalesHeader.Validate("Sell-to Customer No.");
        SalesHeader."Document Date" := Today;
        SalesHeader."Posting Date" := Today;
        SalesHeader."Your Reference" := RentalHeader."No.";
        SalesHeader.Modify(true);

        // Ustvari Sales Lines za vsako vrstico izposoje
        LineNo := 10000;
        RentalLine.FindSet();
        repeat
            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := LineNo;
            SalesLine.Type := SalesLine.Type::Item;
            SalesLine.Validate("No.", 'RENTAL');
            SalesLine.Description := RentalLine.Description;
            SalesLine.Validate(Quantity, RentalLine."Rental Days");
            SalesLine.Validate("Unit Price", RentalLine."Daily Rate");
            SalesLine.Insert(true);

            LineNo += 10000;
        until RentalLine.Next() = 0;

        Message('Prodajni račun %1 je bil uspešno ustvarjen za stranko %2.',
            SalesHeader."No.", RentalHeader."Customer No.");
    end;
}
