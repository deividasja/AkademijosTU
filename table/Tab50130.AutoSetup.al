table 50130 "Auto Setup"
{
    Caption = 'Auto Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Car Nos."; Code[20])
        {
            Caption = 'Car No Series';
            TableRelation = "No. Series";
        }
        field(20; "Rental Card Nos."; Code[20])
        {
            Caption = 'Rental Card No Series';
            TableRelation = "No. Series";
        }
        field(30; "Attachment location"; Code[10])
        {
            Caption = 'Attachment location';
            TableRelation = Location;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Primary Key") { }
        fieldgroup(Brick; "Primary Key") { }
    }

    trigger OnInsert()
    begin
        InitDefaultValues();
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    local procedure InitDefaultValues()
    begin

    end;
}