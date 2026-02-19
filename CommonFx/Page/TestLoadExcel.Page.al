page 99001 "SAD Test Excel"
{
    Caption = 'SAD Test Excel';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;



    actions
    {
        area(Processing)
        {
            action("Upload Excel File")
            {

                trigger OnAction()
                var
                    TempExcelBuffer: record "Excel Buffer" temporary;
                    FileName: text;
                    Ins: InStream;
                    Sheets: Record "Name/Value Buffer" temporary;
                    FirstSheetName: Text;
                    SheetsNames: Text;
                    SelectedSheet: Text;
                    SelectedOption: Integer;
                    Mapa: Dictionary of [Integer, Text];
                    Counter: Integer;
                begin
                    if UploadIntoStream('Dame el Excel', '', 'Excel Files|*.xlsx', Filename, Ins) then begin
                        Sheets.Reset();
                        Sheets.DeleteAll();
                        TempExcelBuffer.GetSheetsNameListFromStream(Ins, Sheets);

                        // Creo el string de opciones, en base a los nombres de la hojas. Como StrMenu se maneja con indices enteros, me creo el mapa
                        if Sheets.FindFirst() then begin
                            FirstSheetName := Sheets.Value;
                            repeat
                                Counter += 1;
                                SheetsNames += Sheets.Value + ',';
                                Mapa.Add(Counter, Sheets.Value);
                            until Sheets.Next() = 0;
                        end;

                        SelectedOption := StrMenu(SheetsNames, 1);
                        Mapa.Get(SelectedOption, SelectedSheet);

                        // Cargo en TempExcelBuffer la hoja seleccionada.
                        TempExcelBuffer.OpenBookStream(InS, SelectedSheet);
                    end;
                end;
            }
        }
    }
}