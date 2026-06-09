namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

codeunit 50111 "Create Sales Invoice"
{
    procedure CreateInvoice(var RentalHeader: Record "Rental Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RentalLine: Record "Rental Line";
        LineNo: Integer;
    begin
        // Preveri status
        if RentalHeader.Status <> RentalHeader.Status::Returned then
            Error('Izposoja mora imeti status Returned, da lahko ustvarite račun.');

        // Ustvari Sales Header
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);                                              // Najprej Insert
        SalesHeader.Validate("Sell-to Customer No.", RentalHeader."Customer No.");  // Validate zapolni ime
        SalesHeader.Validate("Document Date", Today);
        SalesHeader.Validate("Posting Date", Today);
        SalesHeader.Modify(true);                                              //Shrani

        LineNo := 10000;

        // Ustvari Sales Lines iz Rental Lines
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.FindSet() then
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", 'RENTAL');
                SalesLine.Validate(Description, RentalLine.Description);
                SalesLine.Validate(Quantity, RentalLine."Rental Days");
                SalesLine.Validate("Unit Price", RentalLine."Daily Rate");
                SalesLine.Insert(true);

                LineNo += 10000;
            until RentalLine.Next() = 0;

        // Prikaži ustvarjeni račun
        Message('Prodajni račun %1 je bil uspešno ustvarjen.', SalesHeader."No.");

        Page.Run(Page::"Sales Invoice", SalesHeader);
    end;
}