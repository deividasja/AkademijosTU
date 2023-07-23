codeunit 50131 "Return the car function"
{
    procedure ReturnCar(ContractNo: Code[20])
    var
        AutoRentHeaderRec: Record "Auto Rent Header";
        AutoRentLineRec: Record "Auto Rent Line";
        FinishedAutoRentHeaderRec: Record "Finished Auto Rent Header";
        FinishedAutoRentLineRec: Record "Finished Auto Rent Line";
        AutoDamageRec: Record "Auto Damage";
        AutoRentDamageRec: Record "Auto Rent Damage";
    begin
        if AutoRentHeaderRec.Get(ContractNo) then begin
            FinishedAutoRentHeaderRec.Init;

            FinishedAutoRentHeaderRec."No." := ContractNo;
            FinishedAutoRentHeaderRec."Client No." := AutoRentHeaderRec."Client No.";
            FinishedAutoRentHeaderRec."Driver's License" := AutoRentHeaderRec."Driver's License";
            FinishedAutoRentHeaderRec.Date := AutoRentHeaderRec.Date;
            FinishedAutoRentHeaderRec."Car No." := AutoRentHeaderRec."Car No.";
            FinishedAutoRentHeaderRec."Reserved from" := AutoRentHeaderRec."Reserved from";
            FinishedAutoRentHeaderRec."Reserved until" := AutoRentHeaderRec."Reserved until";
            FinishedAutoRentHeaderRec.Sum := AutoRentHeaderRec.Sum;
            FinishedAutoRentHeaderRec.Insert;

            AutoRentLineRec.SetRange("Document No.", ContractNo);
            if AutoRentLineRec.FindSet then begin
                repeat
                    FinishedAutoRentLineRec.Init;

                    FinishedAutoRentLineRec."Document No." := ContractNo;
                    FinishedAutoRentLineRec."Line No." := AutoRentLineRec."Line No.";
                    FinishedAutoRentLineRec.Type := AutoRentLineRec.Type;
                    FinishedAutoRentLineRec."No." := AutoRentLineRec."No.";
                    FinishedAutoRentLineRec.Description := AutoRentLineRec.Description;
                    FinishedAutoRentLineRec.Quantity := AutoRentLineRec.Quantity;
                    FinishedAutoRentLineRec.Price := AutoRentLineRec.Price;
                    FinishedAutoRentLineRec.Sum := AutoRentLineRec.Sum;
                    FinishedAutoRentLineRec.Insert;
                until AutoRentLineRec.Next = 0;
            end;

            AutoRentDamageRec.SetRange("Document No.", ContractNo);
            if AutoRentDamageRec.FindSet then begin
                repeat
                    AutoDamageRec.Init;

                    AutoRentHeaderRec.GET(AutoRentDamageRec."Document No.");
                    AutoDamageRec."Car No." := AutoRentHeaderRec."Car No.";
                    AutoDamageRec."Line No." := AutoRentDamageRec."Line No.";
                    AutoDamageRec.Date := AutoRentDamageRec.Date;
                    AutoDamageRec.Description := AutoRentDamageRec.Description;
                    AutoDamageRec.Status := AutoDamageRec.Status::Relevant;
                    AutoDamageRec.Insert;
                until AutoRentDamageRec.Next = 0;
            end;
            AutoRentDamageRec.SetRange("Document No.", ContractNo);
            AutoRentDamageRec.DELETEALL;

            AutoRentLineRec.SetRange("Document No.", ContractNo);
            AutoRentLineRec.DELETEALL;
            AutoRentHeaderRec.DELETE;
        end;
    end;
}