namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Customer;

report 50110 "Rental Report"
{
    Caption = 'Pregled izposoj po strankah';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultRenderingLayout = WordLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CustomerNo; "No.") { }
            column(CustomerName; Name) { }

            dataitem(RentalHeader; "Rental Header")
            {
                DataItemLink = "Customer No." = FIELD("No.");

                column(RentalNo; "No.") { }
                column(RentalDate; "Rental Date") { }
                column(ExpectedReturnDate; "Expected Return Date") { }
                column(ActualReturnDate; "Actual Return Date") { }
                column(Status; Status) { }
                column(TotalAmount; "Total Amount") { }

                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = FIELD("No.");

                    column(BicycleNo; "Bicycle No.") { }
                    column(Description; Description) { }
                    column(RentalDays; "Rental Days") { }
                    column(DailyRate; "Daily Rate") { }
                    column(LineAmount; "Line Amount") { }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }
        actions
        {
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layouts/RentalOverview.docx';
        }
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/RentalOverview.rdlc';
        }
    }
}