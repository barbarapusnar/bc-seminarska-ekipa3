table 50112 "Rental Header"
{
    Caption = 'Rental Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            NotBlank = true;
            trigger OnValidate()
            begin
                CheckMaxActiveRentals();  // Preveri takoj ko uporabnik vnese stranko
            end;
        }
        field(3; "Rental Date"; Date)
        {
            Caption = 'Rental Date';
            trigger OnValidate()
            begin
                if ("Expected Return Date" <> 0D) and ("Expected Return Date" < "Rental Date")
                then
                    Error('Expected Return Date ne sme biti manjši od Rental Date.');
            end;
        }
        field(4; "Expected Return Date"; Date)
        {
            Caption = 'Expected Return Date';
            trigger OnValidate()
            begin
                if ("Rental Date" <> 0D) and
                   ("Expected Return Date" < "Rental Date") then
                    Error('Expected Return Date ne sme biti manjši od Rental Date.');
            end;
        }
        field(5; "Actual Return Date"; Date)
        {
            Caption = 'Actual Return Date';
        }
        field(6; Status; Enum "Rental Status")
        {
            Caption = 'Status';
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Rental Line"."Line Amount" where("Rental No." = field("No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CheckMaxActiveRentals();
    end;

    local procedure CheckMaxActiveRentals()
    var
        Customer: Record Customer;
        RentalHeader: Record "Rental Header";
        ActiveRentals: Integer;
    begin
        // Preveri samo če je Customer No. izpolnjen
        if "Customer No." = '' then
            exit;

        // Pridobi stranko
        if not Customer.Get("Customer No.") then
            exit;

        // Preveri samo če je Max Active Rentals nastavljen
        if Customer."Max Active Rentals" = 0 then
            exit;

        // Preštej aktivne izposoje
        RentalHeader.SetRange("Customer No.", "Customer No.");
        RentalHeader.SetRange(Status, RentalHeader.Status::Active);
        ActiveRentals := RentalHeader.Count();

        // Javi napako če je prekoračeno
        if ActiveRentals >= Customer."Max Active Rentals" then
            Error('Stranka %1 je že dosegla maksimalno dovoljeno število aktivnih izposoj (%2).',
                "Customer No.", Customer."Max Active Rentals");
    end;
}
