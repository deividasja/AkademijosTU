report 50131 "Auto Rent History Report"
{
    Caption = 'Auto Rent History Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyReport2;

    dataset
    {
        dataitem(Auto; Auto)
        {
            PrintOnlyIfDetail = true;
            column(No_; "No.") { }
            column(Mark; Mark) { }
            column(Model; Model) { }
            dataitem("Finished Auto Rent Header"; "Finished Auto Rent Header")
            {
                DataItemTableView = sorting("Reserved from", "Reserved until");
                DataItemLink = "Car No." = field("No.");
                column(Reserved_from; "Reserved from") { }
                column(Reserved_until; "Reserved until") { }
                column(Client_No_; "Client No.") { }
                column(Sum; Sum) { }

                trigger OnPreDataItem()
                begin
                    SetRange("Reserved from", "Reserved until");
                end;
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
                    field(StartingDateFilterCtrl; StartingDateFilter)
                    {
                        Caption = 'Reserved from filter';

                    }
                    field(EndingDateFilterCtrl; EndingDateFilter)
                    {
                        Caption = 'Reserved until filter';

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
        layout(MyReport2)
        {
            Type = RDLC;
            LayoutFile = './layout/AutoRentHistory.rdl';
        }
    }

    var
        StartingDateFilter: DateTime;
        EndingDateFilter: DateTime;

    trigger OnInitReport()
    begin
        StartingDateFilter := 0DT;
        EndingDateFilter := 0DT;
    end;


    trigger OnPreReport()
    begin
        if StartingDateFilter = 0DT then
            Error('date filter was not specified');
    end;
}