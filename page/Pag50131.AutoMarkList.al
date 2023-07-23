page 50131 "Auto Mark List"
{
    Caption = 'Auto Mark';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Mark";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';

                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';

                }
            }
        }
    }
}