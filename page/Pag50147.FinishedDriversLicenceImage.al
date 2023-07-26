page 50147 "Finished Driver's Image"
{
    Caption = 'Finished Driver''s Image';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ApplicationArea = All;
    UsageCategory = None;
    PageType = CardPart;
    SourceTable = "Finished Auto Rent Header";

    layout
    {
        area(Content)
        {
            group(ImageGroup)
            {
                Caption = 'Picture';
                field("No."; Rec."No.") { Visible = false; }
                field("Driver's License"; Rec."Driver's License")
                {
                    ApplicationArea = All;
                    ToolTip = 'Driver''s licence picture';
                }
            }
        }
    }
}