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
    var
        Customer: Record Customer;
        ActiveRentals: Record "Rental Header";
        ActiveRentalCount: Integer;
    begin
        if "Customer No." = '' then
            exit;

        if not Customer.Get("Customer No.") then
            exit;

        // Preveri samo če ima stranka nastavljeno omejitev
        if Customer."Max Active Rentals" = 0 then
            exit;

        // Preštej aktivne izposoje za stranko
        ActiveRentals.SetRange("Customer No.", "Customer No.");
        ActiveRentals.SetRange(Status, Status::Active);
        ActiveRentalCount := ActiveRentals.Count();

        if ActiveRentalCount >= Customer."Max Active Rentals" then
            Error('Stranka je že dosegla maksimalno dovoljeno število aktivnih izposoj (%1).', Customer."Max Active Rentals");
    end;
}
