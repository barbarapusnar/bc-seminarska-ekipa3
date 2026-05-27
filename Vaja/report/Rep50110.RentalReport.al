namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Customer;

report 50110 "Rental Report"
{
    // NEDELA !!
    Caption = 'Pregled izposoj po strankah';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    //WordLayout = 'Rental_report.docx';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Customer_No; "No.") { }
            column(Customer_Name; Name) { }

            dataitem(RentalHeader; "Rental Header")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Rental_No; "No.") { }
                column(Rental_Date; "Rental Date") { }
                column(Expected_Return_Date; "Expected Return Date") { }
                column(Actual_Return_Date; "Actual Return Date") { }
                column(Rental_Status; Status) { }
                column(Total_Amount; "Total Amount") { }

                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");
                    DataItemTableView = sorting("Rental No.", "Line No.");

                    column(Bicycle_No; "Bicycle No.") { }
                    column(Line_Description; Description) { }
                    column(Rental_Days; "Rental Days") { }
                    column(Daily_Rate; "Daily Rate") { }
                    column(Line_Amount; "Line Amount") { }
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

    labels
    {
        Report_Title = 'Pregled izposoj po strankah';
        Lbl_CustomerNo = 'Šifra stranke';
        Lbl_CustomerName = 'Stranka';
        Lbl_RentalNo = 'Rental No.';
        Lbl_Date = 'Datum';
        Lbl_Bicycle = 'Kolo';
        Lbl_Description = 'Opis';
        Lbl_Days = 'Dni';
        Lbl_Price = 'Cena';
        Lbl_Amount = 'Znesek';
        Lbl_Total = 'Skupni znesek';
    }
}