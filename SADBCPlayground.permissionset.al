permissionset 99000 SAD_BC_Playground
{
    Assignable = true;
    Permissions = tabledata "SAD Table Entry"=RIMD,
        table "SAD Table Entry"=X,
        codeunit "SAD AI Management"=X,
        page "SAD Test AI"=X,
        page "SAD Test Excel"=X,
        tabledata "Web Service Setup"=RIMD,
        tabledata "Web Service Token"=RIMD,
        table "Web Service Setup"=X,
        table "Web Service Token"=X,
        codeunit "Access Token ARCA"=X,
        page "Web Service Setup Card"=X,
        page "Web Service Setups"=X,
        page "Web Service Tokens"=X;
}