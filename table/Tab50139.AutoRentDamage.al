table 50139 "Auto Rent Damage"
{
    Caption = 'Auto Rent Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Auto Rent Header";
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
    }

    keys
    {
        key(PK; "Document No.", "Line No.") { Clustered = true; }
    }

}