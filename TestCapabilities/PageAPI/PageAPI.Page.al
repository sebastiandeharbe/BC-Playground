page 99002 "SAD Page API"
{
    PageType = API;
    Caption = 'apiPage';
    APIPublisher = 'sad';
    APIGroup = 'sadAPI';
    APIVersion = 'v2.0';
    EntityName = 'pageApi';
    EntitySetName = 'pages';
    SourceTable = Customer;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(name; Rec.Name)
                {

                }
            }
        }
    }
}