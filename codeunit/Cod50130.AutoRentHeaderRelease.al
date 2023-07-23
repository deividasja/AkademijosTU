codeunit 50130 "Auto Rent Header - Release"
{
    TableNo = "Auto Rent Header";

    trigger OnRun()
    begin
        OnBeforeReleaseContract(Rec);

        Rec.Status := Rec.Status::Released;
        Rec.Modify(false);

        OnAfterReleaseContract(Rec);
    end;

    procedure OpenContract(var AutoRentHeader: Record "Auto Rent Header")
    begin
        OnBeforeOpenContract(AutoRentHeader);

        AutoRentHeader.Status := AutoRentHeader.Status::Open;
        AutoRentHeader.Modify(true);

        OnAfterOpenContract(AutoRentHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleaseContract(var AutoRentHeader: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseContract(var AutoRentHeader: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenContract(var AutoRentHeader: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenContract(var AutoRentHeader: Record "Auto Rent Header")
    begin
    end;

}
