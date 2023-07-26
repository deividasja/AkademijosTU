page 50146 "Driver's licence Image"
{
    Caption = 'Driver''s licence Image';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ApplicationArea = All;
    UsageCategory = None;
    PageType = CardPart;
    SourceTable = "Auto Rent Header";

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

    actions
    {
        area(Processing)
        {
            action(ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Upload';
                Image = Import;
                ToolTip = 'Upload an image';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        Rec."Driver's License".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }

            action(DeleteMedia)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the image';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to delete the uploaded picture?') then begin
                        Clear(Rec."Driver's License");
                        Rec.Modify(true);
                    end
                    else
                        exit;
                end;
            }
        }
    }

    var
        myInt: Integer;
}