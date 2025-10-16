page 99000 "SAD Test AI"
{
    Caption = 'Test AI';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(PromptText; PromptText)
                {
                    Caption = 'Prompt';
                    MultiLine = true;
                }
                field(Response; Response)
                {
                    Caption = 'Response';
                    MultiLine = true;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Try AI!';
                ApplicationArea = All;
                Image = AboutNav;

                trigger OnAction()
                var
                    AIMgt: Codeunit "SAD AI Management";
                begin
                    Clear(Response);
                    Response := AIMgt.SendAIRequest(PromptText);
                end;
            }
        }
    }

    var
        Response: Text;
        PromptText: Text;
}