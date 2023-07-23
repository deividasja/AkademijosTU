table 50134 "Auto Reservation"
{
    Caption = 'Auto Reservation';
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
        field(20; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(30; "Reserved from"; DateTime)
        {
            Caption = 'Reserved from';

            trigger OnValidate()
            begin
                if ("Reserved until" <> 0DT) and ("Reserved from" > "Reserved until") then
                    Error('The start date of the reservation cannot be later than the end date.');


            end;
        }
        field(40; "Reserved until"; DateTime)
        {
            Caption = 'Reserved until';

            trigger OnValidate()
            begin
                if ("Reserved until" <> 0DT) and ("Reserved from" > "Reserved until") then
                    Error('The start date of the reservation cannot be later than the end date.');

            end;
        }
    }

    keys
    {
        key(Key1; "Car No.", "Line No.") { Clustered = true; }

        key(Key2; "Reserved from", "Reserved until") { }
    }

}