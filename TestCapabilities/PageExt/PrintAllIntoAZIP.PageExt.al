pageextension 99002 "SAD Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action("Save selected")
            {
                Caption = 'Save selected';
                ApplicationArea = All;
                Image = Save;

                trigger OnAction()
                var
                    SalesInvoices: Record "Sales Invoice Header";
                    PostedSalesInvoice: Record "Sales Invoice Header";
                    InStream: InStream;
                    TempBlob: Codeunit "Temp Blob";
                    Filename: Text;
                begin
                    DataCompression.CreateZipArchive();

                    CurrPage.SetSelectionFilter(SalesInvoices);
                    if SalesInvoices.FindSet() then
                        repeat
                            PostedSalesInvoice.Reset();
                            PostedSalesInvoice.SetRange("No.", SalesInvoices."No.");
                            if PostedSalesInvoice.FindFirst() then
                                ReportGeneration(PostedSalesInvoice);
                        until SalesInvoices.Next() = 0;

                    DataCompression.SaveZipArchive(TempBlob);
                    DataCompression.CloseZipArchive();
                    TempBlob.CreateInStream(InStream);
                    Filename := 'archivos.zip';
                    DownloadFromStream(InStream, '', '', '', Filename);
                end;
            }
        }
    }

    local procedure ReportGeneration(var PostedSalesInv: Record "Sales Invoice Header")
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Ins: InStream;
        Filename: Text;
    begin
        ReportSelections.Reset();
        ReportSelections.SetRange(Usage, Enum::"Report Selection Usage"::"S.Invoice");
        if ReportSelections.FindFirst() then begin
            Clear(TempBlob);
            ReportSelections.SaveReportAsPDFInTempBlob(TempBlob, ReportSelections."Report ID", PostedSalesInv, '', Enum::"Report Selection Usage"::"S.Invoice");
            TempBlob.CreateInStream(Ins);
            Filename := Format(PostedSalesInv."No.") + '.pdf';
            DataCompression.AddEntry(Ins, Filename);
        end;
    end;

    var
        DataCompression: Codeunit "Data Compression";

}