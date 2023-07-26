table 50140 "Finished Auto Rent Header"
{
    Caption = 'Finished Auto Rent Header';
    DataClassification = CustomerContent;
    DrillDownPageId = "Auto Rent Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(10; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            TableRelation = Customer;

        }
        field(20; "Driver's License"; Media)
        {
            Caption = 'Drivers license';
        }
        field(30; Date; Date)
        {
            Caption = 'Date';
        }
        field(40; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            TableRelation = Auto;
        }
        field(50; "Reserved from"; DateTime)
        {
            Caption = 'Reserved from';
        }
        field(60; "Reserved until"; DateTime)
        {
            Caption = 'Reserved until';
        }
        field(70; "Sum"; Decimal)
        {
            Caption = 'Sum';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }

        key(Key2; "Reserved from", "Reserved until") { }
    }


    trigger OnInsert()
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Rental Card Nos.");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Rental Card Nos.", WorkDate(), true);
        end;
    end;
}