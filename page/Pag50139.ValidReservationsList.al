page 50139 "Valid Auto Reservations List"
{
    Caption = 'Valid Auto Reservations List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Valid Auto Reservation";

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    InsertAllowed = false;
    ModifyAllowed = false;

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
                }
                field("Reserved until"; Rec."Reserved until")
                {
                    ToolTip = 'Reserved until';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        TodayDateTime: DateTime;
        AutoReservationRec: Record "Auto Reservation";
        ValidAutoReservationRec: Record "Valid Auto Reservation";
    begin
        TodayDateTime := System.CurrentDateTime;
        ValidAutoReservationRec.DeleteAll();
        AutoReservationRec.Reset();
        AutoReservationRec.SetFilter(AutoReservationRec."Reserved until", '>=%1', TodayDateTime);
        if AutoReservationRec.FindSet() then begin
            repeat
                ValidAutoReservationRec.Init;
                ValidAutoReservationRec."Car No." := AutoReservationRec."Car No.";
                ValidAutoReservationRec."Line No." := AutoReservationRec."Line No.";
                ValidAutoReservationRec."Customer No." := AutoReservationRec."Customer No.";
                ValidAutoReservationRec."Reserved from" := AutoReservationRec."Reserved from";
                ValidAutoReservationRec."Reserved until" := AutoReservationRec."Reserved until";
                ValidAutoReservationRec.Insert;
            until AutoReservationRec.Next() = 0;
        end;
    end;
}