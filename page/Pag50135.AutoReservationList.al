page 50135 "Auto Reservation List"
{
    Caption = 'Auto Reservation List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Customer No.';
                }
                field("Reserved from"; Rec."Reserved from")
                {
                    ToolTip = 'Reserved from';

                    trigger OnValidate()
                    begin
                        CheckReservationDates();
                    end;
                }
                field("Reserved until"; Rec."Reserved until")
                {
                    ToolTip = 'Reserved until';

                    trigger OnValidate()
                    begin
                        CheckReservationDates();
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        AutoReservationRec: Record "Auto Reservation";
    begin
        AutoReservationRec.Reset();
        AutoReservationRec.SetRange("Car No.", Rec."Car No.");
        if AutoReservationRec.FindLast then begin
            Rec."Line No." := AutoReservationRec."Line No." + 10000;
        end
        else begin
            Rec."Line No." := 10000;
        end;
    end;


    local procedure CheckReservationDates()
    var
        AutoReservationRec: Record "Auto Reservation";
    begin
        if (Rec."Reserved from" <> 0DT) and (Rec."Reserved until" <> 0DT) then begin
            AutoReservationRec.Reset();
            AutoReservationRec.SetFilter("Car No.", '=%1', Rec."Car No.");
            AutoReservationRec.SetFilter("Line No.", '<>%1', Rec."Line No.");
            AutoReservationRec.SETFILTER("Reserved from", '<=%1', Rec."Reserved until");
            AutoReservationRec.SETFILTER("Reserved until", '>=%1', Rec."Reserved from");
            if AutoReservationRec.FindSet() then
                Error('There cannot be multiple reservations for the same time period, for the same car');
        end;
    end;
}