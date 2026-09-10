codeunit 99003 "SAD Migration Fxs"
{
    procedure ImportarExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        MiTablaDestino: Record "Sales Header"; // Reemplaza por tu tabla
        FileInStream: InStream;
        FileName: Text;
        SheetName: Text;
        RowNo: Integer;
        MaxRowNo: Integer;
        DialogTitle: Label 'Selecciona el archivo Excel a importar';
    begin
        // 1. Abrir cuadro de diálogo para seleccionar el archivo Excel
        if not UploadIntoStream(DialogTitle, '', 'Archivos Excel (*.xlsx)|*.xlsx', FileName, FileInStream) then
            exit;

        // 2. Obtener el nombre de la primera hoja del libro
        SheetName := TempExcelBuffer.SelectSheetsNameStream(FileInStream);
        if SheetName = '' then
            Error('No se encontró ninguna hoja válida en el archivo.');

        // 3. Cargar el contenido en la tabla temporal Excel Buffer
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(FileInStream, SheetName);
        TempExcelBuffer.ReadSheet();

        // 4. Determinar la última fila con datos
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No."
        else
            Error('La hoja seleccionada está vacía.');

        // 5. Procesar fila por fila (iniciamos en la fila 2 para ignorar cabeceras)
        for RowNo := 2 to MaxRowNo do begin
            // Validar que la fila tenga contenido en la columna clave antes de insertar
            if GetCellValue(TempExcelBuffer, RowNo, 1) <> '' then begin
                MiTablaDestino.Init();

                // Mapeo por número de columna (1 = Columna A, 2 = Columna B, etc.)
                MiTablaDestino."No." := CopyStr(GetCellValue(TempExcelBuffer, RowNo, 1), 1, MaxStrLen(MiTablaDestino."No."));
                MiTablaDestino."Posting Description" := CopyStr(GetCellValue(TempExcelBuffer, RowNo, 2), 1, MaxStrLen(MiTablaDestino."Posting Description"));

                // Conversión de tipos de datos numéricos o fechas si aplica:
                // Evaluate(MiTablaDestino."Cantidad", GetCellValue(TempExcelBuffer, RowNo, 3));

                MiTablaDestino.Insert(true);
            end;
        end;

        Message('Proceso finalizado con éxito. Se procesaron %1 filas.', MaxRowNo - 1);
    end;

    local procedure GetCellValue(var ExcelBuf: Record "Excel Buffer" temporary; RowIndex: Integer; ColIndex: Integer): Text
    begin
        if ExcelBuf.Get(RowIndex, ColIndex) then
            exit(ExcelBuf."Cell Value as Text");
        exit('');
    end;
}