table 50136 "Auto Rent Header"
{
    Caption = 'Auto Rent Header';
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

            trigger OnValidate()
            begin
                CheckStatusReleased();

                CountDebt();

                CheckClient();
            end;

        }
        field(20; "Driver's License"; Media)
        {
            Caption = 'Drivers license';

            trigger OnValidate()
            begin
                CheckStatusReleased();
            end;
        }
        field(30; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                CheckStatusReleased();
            end;
        }
        field(40; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            TableRelation = Auto;

            trigger OnValidate()
            begin
                CheckStatusReleased();
            end;
        }
        field(50; "Reserved from"; DateTime)
        {
            Caption = 'Reserved from';

            trigger OnValidate()
            begin
                CheckStatusReleased();

                if ("Reserved until" <> 0DT) and ("Reserved from" > "Reserved until") then
                    Error('The start date of the reservation cannot be later than the end date.');
            end;
        }
        field(60; "Reserved until"; DateTime)
        {
            Caption = 'Reserved until';

            trigger OnValidate()
            begin
                CheckStatusReleased();

                if ("Reserved until" <> 0DT) and ("Reserved from" > "Reserved until") then
                    Error('The start date of the reservation cannot be later than the end date.');
            end;
        }
        field(70; "Sum"; Decimal)
        {
            Caption = 'Sum';
            FieldClass = FlowField;
            CalcFormula = sum("Auto Rent Line".Sum where("Document No." = field("No.")));

            trigger OnValidate()
            begin
                CheckStatusReleased();
            end;

        }
        field(80; "Status"; Enum "Auto Rent Header Status")
        {
            Caption = 'Status';
            Editable = false;
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


    trigger OnModify()
    begin
        CheckStatusReleased();
    end;

    trigger OnRename()
    begin
        Error('Rename not allowed');
    end;


    local procedure CheckStatusReleased()
    begin
        if Rec.Status = Rec.Status::Released then
            Error('Contract Released');
    end;


    local procedure CountDebt()
    var
        CustomerLedgerEntryRec: Record "Cust. Ledger Entry";
        CustomerRec: Record Customer;
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        if "Client No." <> '' then begin
            CustomerLedgerEntryRec.SetRange("Customer No.", "Client No.");
            CustomerLedgerEntryRec.SetFilter("Amount (LCY)", '<>%1', 0);
            if CustomerLedgerEntryRec.FindFirst() then begin
                repeat
                    CustomerLedgerEntryRec.CalcFields("Amount (LCY)");
                    TotalAmount := TotalAmount + CustomerLedgerEntryRec."Amount (LCY)";
                until CustomerLedgerEntryRec.NEXT = 0;
            end;
            if TotalAmount > 0 then begin
                Error('Selected customer has debts.');
            end;
        end;
    end;



    local procedure CheckClient()
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Client No.") then
            Customer.TestField(Blocked, Customer.Blocked::" ");
    end;
}