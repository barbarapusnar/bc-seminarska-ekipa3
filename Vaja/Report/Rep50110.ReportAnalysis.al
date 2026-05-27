namespace bcseminarskaekipa.bcseminarskaekipa;

report 50110 ReportAnalysis
{
    Caption = 'Pregled izposoj po strankah';
    DefaultRenderingLayout = WordLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(RentalHeader; "Rental Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Customer No.", Status;

            column(RentalNo; "No.")
            {
            }
            column(CustomerNo; "Customer No.")
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
            column(RentalStatus; Status)
            {
            }
            column(PrintDate; PrintDateVar)
            {
            }
            column(CompanyNameCol; CompanyNameVar)
            {
            }
            column(ReportTitle; ReportTitleVar)
            {
            }

            dataitem(RentalLine; "Rental Line")
            {
                DataItemLink = "Rental No." = field("No.");
                DataItemTableView = sorting("Rental No.", "Line No.");

                column(BicycleNo; "Bicycle No.")
                {
                }
                column(LineDescription; Description)
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
            }

            trigger OnPreDataItem()
            begin
                PrintDateVar := Today;
                CompanyNameVar := CompanyName();
                ReportTitleVar := 'Pregled izposoj po strankah';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    Caption = 'Filtri';
                }
            }
        }
    }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Rep50110.ReportAnalysis.docx';
            Caption = 'Pregled izposoj (Word)';
        }
    }

    var
        PrintDateVar: Date;
        CompanyNameVar: Text[100];
        ReportTitleVar: Text[100];
}