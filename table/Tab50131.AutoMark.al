table 50131 "Auto Mark"
{
    Caption = 'Auto Mark';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(10; "Description"; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code") { Clustered = true; }
    }
}