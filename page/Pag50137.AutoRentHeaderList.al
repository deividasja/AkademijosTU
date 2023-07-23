page 50137 "Auto Rent Header List"
{
    Caption = 'Auto Rent Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";

    CardPageId = "Auto Rent Header Card";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Driver's License"; Rec."Driver's License")
                {
                    ToolTip = 'Drivers license';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field("Reserved from"; Rec."Reserved from")
                {
                    ToolTip = 'Reserved from';
                }
                field("Reserved until"; Rec."Reserved until")
                {
                    ToolTip = 'Reserved until';
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
            }
        }
    }




    actions
    {
        area(Processing)
        {
            action(ReleaseContract)
            {
                Caption = 'Change status to Released';
                ToolTip = 'Change status to Released';

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Auto Rent Header - Release", Rec);
                end;
            }


            action(OpenContract)
            {
                Caption = 'Change status to Open';
                ToolTip = 'Change status to Open';

                trigger OnAction()
                var
                    AutoRentHeaderRelease: Codeunit "Auto Rent Header - Release";
                begin
                    AutoRentHeaderRelease.OpenContract(Rec);
                end;
            }


            action(ReturnCar)
            {
                Caption = 'Return the car';
                ToolTip = 'Return the car';

                trigger OnAction()
                var
                    ReturnCarFunction: Codeunit "Return the car function";
                begin
                    ReturnCarFunction.ReturnCar(Rec."No.");
                end;
            }


            action(PrintAutoCardReport)
            {
                Caption = 'Print Auto Card';
                ToolTip = 'Print Auto Card';

                trigger OnAction()
                var
                    AutoRentHeader: Record "Auto Rent Header";

                begin
                    AutoRentHeader := Rec;
                    AutoRentHeader.SetRecFilter();
                    Report.RunModal(Report::"Auto Rent Card Report", true, false, AutoRentHeader);
                end;
            }
        }
    }
}