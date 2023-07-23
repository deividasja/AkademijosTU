page 50136 "Auto Damage List"
{
    Caption = 'Auto Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";

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
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
            }
        }
    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Date := System.Today;
    end;
}