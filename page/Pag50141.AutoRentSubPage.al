page 50141 "Auto Rent SubPage"
{
    Caption = 'Lines';

    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Line";

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Rec.Type) { }
                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field(Quantity; Rec.Quantity) { }
                field(Price; Rec.Price) { }
                field(Sum; Rec.Sum) { Editable = false; }
            }
        }
    }


    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Line No." = 10000 then
            Error('This line cannot be deleted');
    end;


    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."Line No." = 10000 then
            Error('This line cannot be deleted');
    end;
}