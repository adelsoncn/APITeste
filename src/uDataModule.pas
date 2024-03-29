unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModuleTeste = class(TDataModule)
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  DMTeste: TDataModuleTeste;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TDataModuleTeste.FDConnectionBeforeConnect(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  FDConnection.Params.Values['Port'] := '3040';
  FDConnection.Params.Values['Server'] := 'localhost';
  {$ELSE}
  FDConnection.Params.Values['Port'] := '3050';
  FDConnection.Params.Values['Server'] := 'Firebird4';
  {$ENDIF}
end;

end.
