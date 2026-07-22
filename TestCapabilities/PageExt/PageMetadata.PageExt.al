pageextension 99003 "SAD Data Search Setup" extends "Data Search Setup (Lists)"
{
    actions
    {
        addlast(Processing)
        {
            action("Seleccionar todas las tablas")
            {
                ApplicationArea = All;
                Image = SelectMore;

                trigger OnAction()
                var
                    PageMetadata: Record "Page Metadata";
                begin
                end;
            }
        }
    }

    var
        myInt: Integer;
}