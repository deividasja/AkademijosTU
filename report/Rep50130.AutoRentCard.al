report 50130 "Auto Rent Card Report"
{
    Caption = 'Auto Rent Card Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyReport1;

    dataset
    {
        dataitem("Finished Auto Rent Header"; "Finished Auto Rent Header")
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

            dataitem("Finished Auto Rent Line"; "Finished Auto Rent Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");

                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Price; Price) { }
                column(Sum; Sum) { }
            }
            column(AutoRentCardTitle; AutoRentCardTitle) { }

            column(FirstLineSum; FirstLineSum) { }
            column(ServiceLinesSum; ServiceLinesSum) { }


            trigger OnAfterGetRecord()
            begin
                FirstLineSum := 0;
                ServiceLinesSum := 0;
                "Finished Auto Rent Line".SetFilter("Document No.", '=%1', "No.");
                "Finished Auto Rent Line".SetFilter("Line No.", '<>%1', 0);
                if "Finished Auto Rent Line".FindSet() then begin
                    repeat
                        if "Finished Auto Rent Line"."Line No." = 10000 then begin
                            FirstLineSum := "Finished Auto Rent Line".Sum;
                        end;
                        if "Finished Auto Rent Line"."Line No." > 10000 then begin
                            ServiceLinesSum += "Finished Auto Rent Line".Sum;
                        end;
                    until "Finished Auto Rent Line".Next = 0;
                end;
            end;
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
        FirstLineSum: Decimal;
        ServiceLinesSum: Decimal;
        AutoRentCardTitle: Label 'Auto Rent Card Report';
}