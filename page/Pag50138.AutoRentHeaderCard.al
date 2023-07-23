page 50138 "Auto Rent Header Card"
{
    Caption = 'Auto Rent Header Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CheckReservationsForHeader();
                    end;
                }
                field("Driver's License"; Rec."Driver's License")
                {
                    ToolTip = 'Drivers license';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CheckReservationsForHeader();

                        InsertResourceLine();
                    end;
                }
                field("Reserved from"; Rec."Reserved from")
                {
                    ToolTip = 'Reserved from';
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CheckReservationsForHeader()
                    end;
                }
                field("Reserved until"; Rec."Reserved until")
                {
                    ToolTip = 'Reserved until';
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CheckReservationsForHeader()
                    end;
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
            }

            part(Lines; "Auto Rent SubPage")
            {
                SubPageLink = "Document No." = field("No.");
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

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Editable := Rec.Status = Rec.Status::Open;
    end;



    local procedure CheckReservationsForHeader()
    var
        AutoReservationRec: Record "Auto Reservation";
    begin
        if (Rec."Reserved from" <> 0DT) and (Rec."Reserved until" <> 0DT) and (Rec."Car No." <> '')
        and (Rec."Client No." <> '') then begin
            AutoReservationRec.Reset();
            AutoReservationRec.SetFilter("Car No.", '=%1', Rec."Car No.");
            AutoReservationRec.SetFilter("Customer No.", '=%1', Rec."Client No.");
            AutoReservationRec.SetFilter("Reserved from", '=%1', Rec."Reserved from");
            AutoReservationRec.SetFilter("Reserved until", '=%1', Rec."Reserved until");
            if not AutoReservationRec.FindSet() then begin
                Error('The car reservation date is invalid');
            end;
        end;
    end;


    local procedure InsertResourceLine()
    var
        AutoRentLineRec: Record "Auto Rent Line";
        AutoRec: Record Auto;
        ResourceRec: Record Resource;
    begin
        AutoRentLineRec.Reset();
        if (Rec."Car No." <> '') then begin
            AutoRentLineRec.SetFilter("Document No.", '=%1', Rec."No.");

            if AutoRentLineRec.FindSet() then begin
                AutoRentLineRec.DeleteAll();
            end;

            if not AutoRentLineRec.FindSet() then begin
                AutoRentLineRec.Init();

                AutoRec.Reset();
                AutoRec.Get(Rec."Car No.");
                AutoRec.SetFilter("No.", '=%1', Rec."Car No.");

                AutoRentLineRec."Document No." := Rec."No.";
                AutoRentLineRec."Line No." := 10000;
                AutoRentLineRec.Type := AutoRentLineRec.Type::Resource;
                AutoRentLineRec."No." := AutoRec."Rental service";

                ResourceRec.Get(AutoRec."Rental service");
                ResourceRec.SetFilter("No.", '=%1', AutoRec."Rental service");
                AutoRentLineRec.Description := ResourceRec.Name;

                AutoRentLineRec.Quantity := 1;
                AutoRentLineRec.Price := ResourceRec."Unit Price";
                AutoRentLineRec.Sum := ResourceRec."Unit Price";

                AutoRentLineRec.Insert();
            end;
        end;
    end;
}