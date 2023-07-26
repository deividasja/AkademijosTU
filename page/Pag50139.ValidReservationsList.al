page 50139 "Valid Auto Reservations List"
{
    Caption = 'Valid Auto Reservations List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";

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

    trigger OnOpenPage();
    var
        TodayDateTime: DateTime;
    begin
        TodayDateTime := System.CurrentDateTime;
        Rec.Reset();
        Rec.SetFilter("Reserved until", '>=%1', TodayDateTime);
    end;
}