unit uConnection;

interface

uses
  uDataModule,
  DataSet.Serialize,
  DataSet.Serialize.Config,
  System.JSON,
  Data.DB, System.SysUtils;

type

  TConnTeste = class
    private
    public
      procedure create;
      class function GetData: TJsonObject;
  end;

implementation

{ TConnTeste }

procedure TConnTeste.create;
begin

end;

class function TConnTeste.GetData: TJsonObject;
var
  LJSONObject: TJsonObject;
  LJSONArray: TJSONArray;
  LDataModule: TDataModuleTeste;
begin
  LDataModule := TDataModuleTeste.Create(nil);
  // Configuração
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.DateInputIsUTC := true;
  TDataSetSerializeConfig.GetInstance.Export.FormatFloat := '0.00##';
  TDataSetSerializeConfig.GetInstance.Export.FormatCurrency := '0.00##';
  TDataSetSerializeConfig.GetInstance.Export.FormatDate := 'yyyy-mm-dd';
  TDataSetSerializeConfig.GetInstance.Export.FormatTime := 'hh:mm:ss';
  TDataSetSerializeConfig.GetInstance.Export.FormatDateTime := 'yyyy-mm-dd"T"hh:nn:ss.zzz';
  // Coleta de dados
  with LDataModule.FDQuery do begin
    SQL.Clear;
    SQL.Add('Select * from ESTADO');
    Active := true;
  end;
  // Retorno JSON
  LJSONObject := TJSONObject.Create;
  try
    LJSONObject := TJsonObject.Create;
    LJSONObject.AddPair('sucess', TJSONTrue.Create);
    LJSONObject.AddPair('code', TJSONNumber.Create(200));
    LJSONArray := LDataModule.FDQuery.ToJSONArray();
    LJSONObject.AddPair('count', TJSONNumber.Create(LDataModule.FDQuery.RecordCount));
    {$IFDEF MSWINDOWS}
    LJSONObject.AddPair('server', 'Windows');
    {$ELSE}
    LJSONObject.AddPair('server', 'Linux');
    {$ENDIF}
    LJSONObject.AddPair('data', LJSONArray);
  finally
    result := LJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONObject.ToString), 0) as TJSONObject;
    LJSONObject.DisposeOf;
    FreeAndNil(LDataModule);
  end;
end;


end.
