pageextension 99000 "SAD Sales Order List" extends "Sales Order List"
{

    actions
    {
        addlast(processing)
        {

            action(DuplicateRecord)
            {
                Caption = 'Duplicate Record';
                ApplicationArea = All;
                Image = CheckDuplicates;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    NewSalesLine: Record "Sales Line";
                    LastEntryNo: Integer;
                    NoSeries: Codeunit "No. Series";
                begin
                    SalesHeader.Init();
                    SalesHeader.TransferFields(Rec);
                    SalesHeader."No." := NoSeries.GetNextNo(Rec.GetNoSeriesCode(), Today);
                    SalesHeader.Insert(true);

                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if SalesLine.FindSet() then
                        repeat
                            NewSalesLine.Init();
                            NewSalesLine.TransferFields(SalesLine);
                            NewSalesLine."Document No." := SalesHeader."No.";
                            NewSalesLine.Insert();
                        until SalesLine.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}