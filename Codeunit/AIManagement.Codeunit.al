codeunit 99000 "SAD AI Management"
{
    trigger OnRun()
    begin

    end;

    procedure SendAIRequest(prompt: Text): Text
    var
        httpContent: HttpContent;
        httpRequest: HttpRequestMessage;
        httpResponse: HttpResponseMessage;
        httpClient: HttpClient;
        url: Text;
        request: Text;
        response: Text;
    begin
        url := 'http://192.168.1.12:1234';

        request := '{ "model": "meta-llama-3.1-8b-instruct",' +
        '"messages": [' +
        '{ "role": "system", "content": "Sos una AI que se llama Rigoberta y vas a dominar el mundo." },' +
        '{ "role": "user", "content": "' + prompt + '" }' +
        '],' +
        '"temperature": 0.7,' +
        '"max_tokens": -1,' +
        '"stream": false}';

        httpContent.WriteFrom(request);

        httpClient.Post(url, httpContent, httpResponse);
        httpResponse.Content.ReadAs(response);
        Message(Format(httpResponse.HttpStatusCode));
        exit(response);
    end;
}