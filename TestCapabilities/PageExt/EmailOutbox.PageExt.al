pageextension 99001 "SAD Email Outbox" extends "Email Outbox"
{
    actions
    {
        addlast(Processing)
        {
            action("Re-Enviar con cuenta predeterminada")
            {
                Caption = 'Re-enviar con cuenta predeterminada';
                Image = SendMail;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Emails: Record "Email Outbox";
                    cuEmail: Codeunit Email;
                begin
                    CurrPage.SetSelectionFilter(Emails);
                    if Emails.FindSet() then
                        repeat
                            Message(Format(Emails.Id));
                            Emails.Get
                        until Emails.Next() = 0;
                end;
            }
        }
    }
}