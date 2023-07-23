page 50142 "Auto Rent Damage List"
{
    Caption = 'Auto Rent Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Damage";

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
                field("Document No."; Rec."Document No.")
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
            }
        }
    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        AutoRentDamageRec: Record "Auto Rent Damage";
    begin
        Rec.Date := System.Today;
        AutoRentDamageRec.Reset();
        AutoRentDamageRec.SetRange("Document No.", Rec."Document No.");
        if AutoRentDamageRec.FindLast then begin
            Rec."Line No." := AutoRentDamageRec."Line No." + 10000;
        end
        else begin
            Rec."Line No." := 10000;
        end;
    end;
}