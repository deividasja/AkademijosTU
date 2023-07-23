table 50141 "Finished Auto Rent Line"
{
    Caption = 'Finished Auto Rent Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; Type; Enum "Auto Rent Line Type")
        {
            Caption = 'Type';
            trigger OnValidate()
            begin
                ClearFieldsAfterChange();
            end;
        }
        field(20; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation =
                if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item;

            trigger OnValidate()
            begin
                FindDescriptionByType();
                FindPriceByType();
            end;

        }
        field(30; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Sum := Round(Quantity * Price);
            end;
        }

        field(50; Price; Decimal)
        {
            Caption = 'Price';

            trigger OnValidate()
            begin
                Sum := Round(Quantity * Price);
            end;
        }
        field(60; Sum; Decimal)
        {
            Caption = 'Sum';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.") { Clustered = true; }
    }




    local procedure FindDescriptionByType()
    var
        ResourceRec: Record Resource;
        ItemRec: Record Item;
    begin
        case Type of
            Type::Resource:
                begin
                    if ResourceRec.get("No.") then
                        Description := ResourceRec.Name;
                end;
            Type::Item:
                begin
                    if ItemRec.get("No.") then
                        Description := ItemRec.Description;
                end;
        end;
    end;


    local procedure FindPriceByType()
    var
        ResourceRec: Record Resource;
        ItemRec: Record Item;
    begin
        case Type of
            Type::Resource:
                begin
                    if ResourceRec.get("No.") then
                        Price := ResourceRec."Unit Price";
                end;
            Type::Item:
                begin
                    if ItemRec.get("No.") then
                        Price := ItemRec."Unit Price";
                end;
        end;
    end;


    local procedure ClearFieldsAfterChange()
    begin
        "No." := '';
        Description := '';
        Quantity := 0;
        Price := 0;
        Sum := 0;
    end;
}