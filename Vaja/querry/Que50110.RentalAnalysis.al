namespace bcseminarskaekipa.bcseminarskaekipa;
using Microsoft.Sales.Customer;

query 50110 "Rental Analysis"
{
    Caption = 'Rental Analysis';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;

    elements
    {
        dataitem(Rental_Header; "Rental Header")
        {
            DataItemTableFilter = Status = const(Active);

            column(Rental_No; "No.")
            {
                Caption = 'Rental No.';
            }
            column(Customer_No; "Customer No.")
            {
                Caption = 'Customer No.';
            }
            column(Rental_Status; Status)
            {
                Caption = 'Rental Status';
            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = Rental_Header."Customer No.";
                SqlJoinType = LeftOuterJoin;

                column(Customer_Name; Name)
                {
                    Caption = 'Customer Name';
                }

                dataitem(Rental_Line; "Rental Line")
                {
                    DataItemLink = "Rental No." = Rental_Header."No.";
                    SqlJoinType = InnerJoin;

                    column(Bicycle_No; "Bicycle No.")
                    {
                        Caption = 'Bicycle No.';
                    }
                    column(Rental_Days; "Rental Days")
                    {
                        Caption = 'Rental Days';
                    }
                    column(Line_Amount; "Line Amount")
                    {
                        Caption = 'Line Amount';
                    }


                    dataitem(Bicycle; Bicycle)
                    {
                        DataItemLink = No = Rental_Line."Bicycle No.";
                        SqlJoinType = LeftOuterJoin;

                        column(Bicycle_Description; Description)
                        {
                            Caption = 'Bicycle Description';
                        }
                    }
                }

            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}