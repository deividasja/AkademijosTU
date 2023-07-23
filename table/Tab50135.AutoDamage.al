table 50135 "Auto Damage"
{
    Caption = 'Auto Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            TableRelation = Auto;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "Date"; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                if (Date <> 0D) and (Date > Today) then begin
                    Error('Date cannot be greater than today');
                end;
            end;
        }
        field(30; "Description"; Text[30])
        {
            Caption = 'Description';
        }
        field(40; "Status"; Enum "Auto Damage Status")
        {
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK; "Car No.", "Line No.") { Clustered = true; }
    }

}