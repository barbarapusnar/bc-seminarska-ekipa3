namespace bcseminarskaekipa.bcseminarskaekipa;

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
}
