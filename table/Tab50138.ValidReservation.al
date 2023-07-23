table 50138 "Valid Auto Reservation"
{
    Caption = 'Valid Auto Reservations';
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
        }
        field(40; "Reserved until"; DateTime)
        {
            Caption = 'Reserved until';
        }
    }

    keys
    {
        key(Key1; "Car No.", "Line No.") { Clustered = true; }

        key(Key2; "Reserved from", "Reserved until") { }
    }

}