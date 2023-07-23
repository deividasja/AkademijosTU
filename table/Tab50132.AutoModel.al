table 50132 "Auto Model"
{
    Caption = 'Auto Model';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Brand Code"; Code[20])
        {
            Caption = 'Mark Code';
            TableRelation = "Auto Mark";
        }
        field(10; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(20; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Brand code", Code) { Clustered = true; }
    }
}