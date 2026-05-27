namespace bcseminarskaekipa.bcseminarskaekipa;

query 50110 RentalAnalysis
{
    Caption = 'Rental Analysis';
    QueryType = Normal;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            filter(StatusFilter; Status)
            {
            }

            column(RentalNo; "No.")
            {
                Caption = 'Rental No.';
            }
            column(CustomerNo; "Customer No.")
            {
                Caption = 'Customer No.';
            }
            column(RentalStatus; Status)
            {
                Caption = 'Rental Status';
            }
            column(RentalDate; "Rental Date")
            {
                Caption = 'Rental Date';
            }
            column(ExpectedReturnDate; "Expected Return Date")
            {
                Caption = 'Expected Return Date';
            }

            dataitem(RentalLine; "Rental Line")
            {
                DataItemLink = "Rental No." = RentalHeader."No.";
                SqlJoinType = InnerJoin;

                column(LineNo; "Line No.")
                {
                    Caption = 'Line No.';
                }
                column(RentalDays; "Rental Days")
                {
                    Caption = 'Rental Days';
                }
                column(LineAmount; "Line Amount")
                {
                    Caption = 'Line Amount';
                }

                dataitem(Bicycle; Bicycle)
                {
                    DataItemLink = "No" = RentalLine."Bicycle No.";
                    SqlJoinType = InnerJoin;

                    column(BicycleNo; "No")
                    {
                        Caption = 'Bicycle No.';
                    }
                    column(BicycleDescription; Description)
                    {
                        Caption = 'Bicycle Description';
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetFilter(StatusFilter, Format(Enum::"Rental Status"::Active));
    end;
}