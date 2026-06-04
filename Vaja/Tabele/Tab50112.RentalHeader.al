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
        CustomerRec: Record Customer;
        RentalHeader: Record "Rental Header";
        ActiveRentals: Integer;
    begin
        // 1. preveri stranko
        if "Customer No." = '' then
            Error('Customer No. is missing.');

        if not CustomerRec.Get("Customer No.") then
            Error('Customer does not exist.');

        // 2. preštej aktivne izposoje
        RentalHeader.Reset();
        RentalHeader.SetRange("Customer No.", "Customer No.");
        RentalHeader.SetRange(Status, RentalHeader.Status::Active);

        ActiveRentals := RentalHeader.Count();

        // 3. preveri limit
        if CustomerRec."Max Active Rentals" > 0 then
            if ActiveRentals >= CustomerRec."Max Active Rentals" then
                Error('Stranka je že dosegla maksimalno dovoljeno število aktivnih izposoj.');
    end;
}
