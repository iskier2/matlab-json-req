% bibliotunie
import matlab.net.http.*
import matlab.net.http.field.*
% wczytanie JSONa do zmiennej data
clear;
fid = fopen('data.json');
data = jsondecode(char(fread(fid,inf)'));
fclose(fid);
% zmiana w JSONie
data.quiz.maths.q1.question = '15 - 3 = ?';
% POST
request = RequestMessage( 'POST', ...
    [ContentTypeField( 'application/vnd.api+json' ), AcceptField('application/vnd.api+json')], ...
    jsonencode(data) );
response = request.send( 'https://jsonplaceholder.typicode.com/posts' );
%obsługa błędów
%tu zależy co dokładnie chcesz akceptować ale jak post to chyba created (201)
if response.StatusCode == matlab.net.http.StatusCode.Created || response.StatusCode == matlab.net.http.StatusCode.OK
    disp("przeszło");
    disp(response.Body.Data)
else
    disp("error");
end
clear; %to czyści wszystkie zmienne
% GET
request = RequestMessage( 'GET', [ContentTypeField( 'application/vnd.api+json' ), AcceptField('application/vnd.api+json')]);
response = request.send( 'https://jsonplaceholder.typicode.com/posts' );
data = response.Body.Data;
%filtrowanie - to działa na macierzach crazy shit, dlatego w ogóle matlab jest spoko
filtredData = data([data.id] > 50);
disp(filtredData)
%wyświetlenie danych
for ind = 1:length(filtredData)
    disp(filtredData(ind))
end