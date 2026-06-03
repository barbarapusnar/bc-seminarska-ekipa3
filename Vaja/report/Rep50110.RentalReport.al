namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Customer;

report 50110 "Rental Report"
{
    Caption = 'Pregled izposoj po strankah';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordMergeDataItem = customer;

    DefaultRenderingLayout = WordLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(CustomerNo; "No.") { }
            column(CustomerName; Name) { }
            column(TodayDate; Today) { }

            dataitem(RentalHeader; "Rental Header")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = where(Status = const(Active));

                column(RentalNo;
                "No.")
                { }
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
            trigger OnAfterGetRecord()
            var
                RentalHeader: Record "Rental Header";
            begin
                RentalHeader.SetRange("Customer No.", "No.");
                RentalHeader.SetRange(Status, RentalHeader.Status::Active);
                if RentalHeader.IsEmpty() then
                    CurrReport.Skip();
            end;
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