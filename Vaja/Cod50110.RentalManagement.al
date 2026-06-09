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
        RentalHeader.TestField("Customer No.");

        if RentalHeader.Status <> RentalHeader.Status::Returned then
            Error('Rental must be returned before invoicing.');

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", RentalHeader."Customer No.");
        SalesHeader.Validate("Document Date", Today);
        SalesHeader.Modify(true);

        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        LineNo := 10000;

        if RentalLine.FindSet() then
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.Insert(true);

                SalesLine.Validate(Type, SalesLine.Type::Item);
                SalesLine.Validate("No.", 'RENTAL');

                SalesLine.Validate(Description, RentalLine.Description);
                SalesLine.Validate(Quantity, RentalLine."Rental Days");
                SalesLine.Validate("Unit Price", RentalLine."Daily Rate");

                SalesLine.Modify(true);

                LineNo += 10000;
            until RentalLine.Next() = 0;

        Message(
            'Sales Invoice %1 created successfully.',
            SalesHeader."No.");
    end;
}
