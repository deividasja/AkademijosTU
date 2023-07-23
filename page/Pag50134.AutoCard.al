page 50134 "Auto Card"
{

    Caption = 'Auto Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Auto;

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
                field(Title; Rec.Title)
                {
                    ToolTip = 'Title';
                }
                field(Mark; Rec.Mark)
                {
                    ToolTip = 'Mark';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Model';
                }
                field("Year of manufacture"; Rec."Year of manufacture")
                {
                    ToolTip = 'Year of manufacture';
                }
                field("Civil insurance is valid until"; Rec."Civil insurance is valid until")
                {
                    ToolTip = 'Civil insurance is valid until';
                }
                field("TA is valid until"; Rec."TA is valid until")
                {
                    ToolTip = 'TA is valid until';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Location Code';
                }
                field("Rental service"; Rec."Rental service")
                {
                    ToolTip = 'Rental service';
                }
                field("Rental price"; Rec."Rental price")
                {
                    ToolTip = 'Rental price';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action(OpenAutoReservationList)
            {
                Caption = 'Auto Reservations';
                ToolTip = 'Auto Reservations';
                Image = Action;
                ApplicationArea = All;

                RunObject = page "Auto Reservation List";
            }
        }
    }

}