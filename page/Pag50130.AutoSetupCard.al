page 50130 "Auto Setup Card"
{
    Caption = 'Auto Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Car Nos."; Rec."Car Nos.")
                {
                    ToolTip = 'Car No Series';
                }
                field("Rental Card Nos."; Rec."Rental Card Nos.")
                {
                    ToolTip = 'Rental Card No Series';
                }
                field("Attachment location"; Rec."Attachment location")
                {
                    ToolTip = 'Attachment location';
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}