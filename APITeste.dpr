program APITeste;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Compression,
  Horse.Jhonson,
  System.JSON,
  System.SysUtils,
  uConnection in 'src\uConnection.pas',
  uDataModule in 'src\uDataModule.pas' {DataModuleTeste: TDataModule};

begin
{$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  try
    var
      LMsg: String;
    THorse
      .Use(Compression())
//      .Use(Jhonson('iso-8859-1'));
      .Use(Jhonson('UTF-8'));

    THorse
    .Get('/version',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('Versão de teste API').Status(THTTPStatus.OK);
    end);

    THorse
    .Get('/estado',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LResult: TJSONObject;
    begin
      LResult := TConnTeste.GetData;
      try
        Res.Send<TJSONObject>(LResult).Status(THTTPStatus.OK);
      except
        on E: Exception do
          Res.Send(E.Message).Status(THTTPStatus.BadRequest);
      end;
    end);


    THorse
      .Listen(9000,
    procedure(Horse: THorse)
    begin
      LMsg := Format('Server is runing on [ %s:%d ]', [Horse.Host, Horse.Port]);
      Writeln('Versão de teste API');
      Writeln(LMsg);
      Writeln(StringOfChar('*', LMsg.Length));
    Readln;
    end)
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;


end.
