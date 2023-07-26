page 50143 "Finished Auto Rent Header Card"
{
    Caption = 'Finished Auto Rent Header Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Header";
    Editable = false;


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
            }

            part(Lines; "Finished Auto Rent SubPage")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }

        area(FactBoxes)
        {
            part(MyPart1; "Finished Driver's Image")
            {
                SubPageLink = "No." = field("No.");
                Caption = 'Driver''s license';
            }
        }
    }
}