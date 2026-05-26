namespace bcseminarskaekipa.bcseminarskaekipa;

codeunit 50110 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Preveri status izposoje
        if RentalHeader.Status <> RentalHeader.Status::Open then
            Error('Izposojo je mogoče začeti samo, če je status Open. Trenutni status: %1.', RentalHeader.Status);

        // Preveri, ali izposoja vsebuje vsaj eno vrstico
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Izposoja %1 ne vsebuje nobene vrstice.', RentalHeader."No.");

        // Preveri, ali so vsa kolesa na voljo
        RentalLine.FindSet();
        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 ne obstaja v sistemu.', RentalLine."Bicycle No.");
            if Bicycle.Status <> Bicycle.Status::Available then
                Error('Kolo %1 ni na voljo za izposojo. Trenutni status: %2.', Bicycle."No", Bicycle.Status);
        until RentalLine.Next() = 0;

        // Nastavi status koles na Rented
        RentalLine.FindSet();
        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Rented;
            Bicycle.Modify();
        until RentalLine.Next() = 0;

        // Nastavi status izposoje na Active
        RentalHeader.Status := RentalHeader.Status::Active;
        RentalHeader.Modify();

        Message('Izposoja %1 je bila uspešno začeta.', RentalHeader."No.");
    end;

    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // Preveri status izposoje
        if RentalHeader.Status <> RentalHeader.Status::Active then
            Error('Vračilo je mogoče obdelati samo, če je status Active. Trenutni status: %1.', RentalHeader.Status);

        // Preveri, ali izposoja vsebuje vsaj eno vrstico
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Izposoja %1 ne vsebuje nobene vrstice.', RentalHeader."No.");

        // Preveri, ali vsa kolesa obstajajo v sistemu
        RentalLine.FindSet();
        repeat
            if not Bicycle.Get(RentalLine."Bicycle No.") then
                Error('Kolo %1 iz vrstice ne obstaja v sistemu.', RentalLine."Bicycle No.");
        until RentalLine.Next() = 0;

        // Nastavi status koles na Available
        RentalLine.FindSet();
        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Available;
            Bicycle.Modify();
        until RentalLine.Next() = 0;

        // Nastavi datum vračila in status izposoje
        RentalHeader."Actual Return Date" := Today;
        RentalHeader.Status := RentalHeader.Status::Returned;
        RentalHeader.Modify();

        Message('Izposoja %1 je bila uspešno zaključena. Datum vračila: %2.', RentalHeader."No.", Today);
    end;
}