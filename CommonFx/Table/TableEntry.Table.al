table 99000 "SAD Table Entry"
{
    Caption = 'SAD Table Entry', Comment = 'ESP="Tabla Movimiento"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', Comment = 'ESP="N° Mov."';
        }
        field(2; "Entry Date"; Date)
        {
            Caption = 'Entry Date', Comment = 'ESP="Fecha Mov."';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;
}