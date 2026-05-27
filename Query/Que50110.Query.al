query 50110 "Active Rental Analysis"
{
    Caption = 'Active Rental Analysis';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            DataItemTableFilter = Status = const(Active);

            column(RentalNo; "No.") { }
            column(CustomerNo; "Customer No.") { }
            column(Status; Status) { }

            dataitem(RentalLine; "Rental Line")
            {
                DataItemLink = "Rental No." = RentalHeader."No.";

                column(BicycleNo; "Bicycle No.") { }
                column(RentalDays; "Rental Days") { }
                column(LineAmount; "Line Amount") { }



            }
        }
    }
}