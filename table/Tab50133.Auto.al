table 50133 "Auto"
{
    Caption = 'Auto';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

        }
        field(10; "Title"; Text[30])
        {
            Caption = 'Title';

        }
        field(20; "Mark"; Code[20])
        {
            Caption = 'Mark';
            TableRelation = "Auto Mark";
        }
        field(30; "Model"; Code[20])
        {
            Caption = 'Model';
            TableRelation = "Auto Model".Code where("Brand Code" = field(Mark));
        }
        field(40; "Year of manufacture"; Integer)
        {
            Caption = 'Year of manufacture';

            trigger OnValidate()
            var
                CurrentYear: Integer;
            begin
                CurrentYear := Date2DMY(Today, 3);
                if ("Year of manufacture" <> 0) and ("Year of manufacture" > CurrentYear) then begin
                    Error('The year of manufacture cannot be greater than the current year');
                end;
            end;

        }
        field(50; "Civil insurance is valid until"; Date)
        {
            Caption = 'Civil insurance is valid until';

            trigger OnValidate()
            begin
                if ("Civil insurance is valid until" <> 0D) and ("Civil insurance is valid until" < Today) then begin
                    Error('Civil insurance is no longer valid');
                end;
            end;
        }
        field(60; "TA is valid until"; Date)
        {
            Caption = 'TA is valid until';

            trigger OnValidate()
            begin
                if ("TA is valid until" <> 0D) and ("TA is valid until" < Today) then begin
                    Error('TA is no longer valid');
                end;
            end;
        }
        field(70; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;

        }
        field(80; "Rental service"; Code[20])
        {
            Caption = 'Rental service';
            TableRelation = Resource;

            trigger OnValidate()
            begin
                CalcFields("Rental price");
            end;
        }
        field(90; "Rental price"; Decimal)
        {
            Caption = 'Rental price';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rental service")));
        }
    }


    keys
    {
        key(PK; "No.") { Clustered = true; }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "No.", Title, Mark, Model, "Year of manufacture", "Rental service", "Rental price") { }
    }


    trigger OnInsert()
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Car Nos.");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Car Nos.", WorkDate(), true);
        end;
    end;
}