object DataModuleTeste: TDataModuleTeste
  Height = 514
  Width = 433
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=/firebird/data/teste.fdb'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3040'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    BeforeConnect = FDConnectionBeforeConnect
    Left = 86
    Top = 96
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from estado')
    Left = 192
    Top = 232
  end
end
