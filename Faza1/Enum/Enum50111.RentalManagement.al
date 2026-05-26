codeunit 50110 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // 1. preveri status
        if RentalHeader.Status <> RentalHeader.Status::Available then
            Error('Rental must be Open to start.');

        // 2. preveri ali obstajajo vrstice
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Rental must contain at least one line.');

        // 3. preveri kolesa
        if RentalLine.FindSet() then
            repeat
                if not Bicycle.Get(RentalLine."Bicycle No.") then
                    Error('Bicycle %1 does not exist.', RentalLine."Bicycle No.");

                if Bicycle.Status <> Bicycle.Status::Available then
                    Error('Bicycle %1 is not available.', Bicycle."No");
            until RentalLine.Next() = 0;

        // 4. spremeni status koles v Rented
        RentalLine.FindSet();
        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Rented;
            Bicycle.Modify();
        until RentalLine.Next() = 0;

        // 5. update header
        RentalHeader.Status := RentalHeader.Status::Available;
        RentalHeader.Modify();
    end;


    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        Bicycle: Record Bicycle;
    begin
        // 1. preveri status
        if RentalHeader.Status <> RentalHeader.Status::Available then
            Error('Rental must be Active to return.');

        // 2. preveri vrstice
        RentalLine.SetRange("Rental No.", RentalHeader."No.");
        if RentalLine.IsEmpty() then
            Error('Rental must contain at least one line.');

        // 3. preveri obstoj koles
        if RentalLine.FindSet() then
            repeat
                if not Bicycle.Get(RentalLine."Bicycle No.") then
                    Error('Bicycle %1 does not exist.', RentalLine."Bicycle No.");
            until RentalLine.Next() = 0;

        // 4. nastavi kolesa nazaj na Available
        RentalLine.FindSet();
        repeat
            Bicycle.Get(RentalLine."Bicycle No.");
            Bicycle.Status := Bicycle.Status::Available;
            Bicycle.Modify();
        until RentalLine.Next() = 0;

        // 5. update header
        RentalHeader."Actual Return Date" := Today();
        RentalHeader.Status := RentalHeader.Status::Available;
        RentalHeader.Modify();
    end;
}