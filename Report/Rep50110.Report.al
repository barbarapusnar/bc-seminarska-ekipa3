using Microsoft.Sales.Customer;
report 50120 "Customer Rental Report"
{
    Caption = 'Customer Rental Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = Word;

    WordLayout = 'CustomerRentalReport.docx';
    RDLCLayout = 'CustomerRentalReport.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(CustomerNo; "No.")
            {
            }

            column(CustomerName; Name)
            {
            }

            column(CompanyName; CompanyName)
            {
            }

            column(TodayDate; Today)
            {
            }

            column(CustomerTotalAmount; CustomerTotalAmount)
            {
            }

            dataitem(RentalHeader; "Rental Header")
            {
                DataItemLink = "Customer No." = field("No.");

                column(RentalNo; "No.")
                {
                }

                column(RentalDate; "Rental Date")
                {
                }

                column(ExpectedReturnDate; "Expected Return Date")
                {
                }

                column(ActualReturnDate; "Actual Return Date")
                {
                }

                column(Status; Status)
                {
                }

                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");

                    column(BicycleNo; "Bicycle No.")
                    {
                    }

                    column(Description; Description)
                    {
                    }

                    column(RentalDays; "Rental Days")
                    {
                    }

                    column(DailyRate; "Daily Rate")
                    {
                    }

                    column(LineAmount; "Line Amount")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CustomerTotalAmount += "Line Amount";
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                CustomerTotalAmount := 0;
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                }
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        CompanyName: Text[100];
        CustomerTotalAmount: Decimal;

    trigger OnPreReport()
    begin
        if CompanyInformation.Get() then
            CompanyName := CompanyInformation.Name;
    end;
}