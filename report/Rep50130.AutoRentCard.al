report 50130 "Auto Rent Card Report"
{
    Caption = 'Auto Rent Card Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyReport1;

    dataset
    {
        dataitem("Auto Rent Header"; "Auto Rent Header")
        {
            PrintOnlyIfDetail = true;
            column(No_; "No.") { }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Car No.");
                column(Mark; Mark) { }
                column(Model; Model) { }
            }
            column(Reserved_from; "Reserved from") { }
            column(Reserved_until; "Reserved until") { }
            column(Client_No_; "Client No.") { }

            dataitem("Auto Rent Line"; "Auto Rent Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Price; Price) { }
                column(Sum; Sum) { }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; myInt)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(MyReport1)
        {
            Type = RDLC;
            LayoutFile = './layout/AutoRentCard.rdl';
        }
    }

    var
        myInt: Integer;
}