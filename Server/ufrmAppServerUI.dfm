object frmAppServerUI: TfrmAppServerUI
  Left = 173
  Top = 102
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Application Server'
  ClientHeight = 438
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 57
    Align = alTop
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 157
      Height = 13
      Caption = 'BlockBuster'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 31
      Width = 103
      Height = 13
      Caption = 'Servidor de Aplica'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 419
    Width = 672
    Height = 19
    Panels = <
      item
        Text = 'Powered by P2S Business Framework'
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 99
    Width = 209
    Height = 305
    Caption = 'User Monitor'
    TabOrder = 2
    object lstUsers: TListBox
      Left = 9
      Top = 20
      Width = 189
      Height = 274
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 232
    Top = 99
    Width = 428
    Height = 305
    Caption = 'Object Repository Monitor'
    TabOrder = 3
    object lstPersistentRepos: TListBox
      Left = 9
      Top = 20
      Width = 200
      Height = 274
      ItemHeight = 13
      TabOrder = 0
    end
    object lstNonPersistentRepos: TListBox
      Left = 217
      Top = 20
      Width = 200
      Height = 274
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object cmdStartServer: TBitBtn
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 4
    OnClick = cmdStartServerClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0ACC2B165AD6E5CB46789BF95C1C3
      C1C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0BDBDBFBABA9C
      B9A138A9471F9F2F20A02F2FB74080C489C1C3C1C0C0C0C0C0C0C0C0C0C0C0C0
      C2C0C0C0ABAACD9C96D0A79FCFA79070C880209F301F98206FA75F4FA84F30B8
      406EC080C0C0C0C0C0C0C0C0C0C0C0C0BF938EECC7C0FFE8E0FFDFD0E0D0B080
      E89F209F30109020B0BF9FD0D0BF50B05038BF55BEC1BFC0C0C0C0C0C0C0B6B6
      EFC0BFFFE8E0FFEFEFFFDFD0EFC8B080D8902FA8400F8710BFC0A0E0D0C0AFC7
      9F40AF4FAFC6B3C0C0C0C0C0C0C0B0B0FFD7CFFFE8E0FFEFEFFFDFD0FFC8BFA0
      C08F3FB7501087104F9F4F4FA04F2F9F302FAF3FA7C4ACC0C0C0C0C0C0C0B0B0
      FFD8D0FFE8E0FFEFE0FFDFD0FFC7BFF0B8A05F9F4F1F88200F871010901F1F98
      2F2AA239BDC1BEC0C0C0C0C0C0C0B0B0FFD8D0FFE8E0FFEFE0FFDFD0FFC7BFFF
      B8AFE0AF9080985F1F801F0F871030983DA8C2ADC0C0C0C0C0C0C0C0C0C0B0B0
      FFD7CFFFE8E0FFEFE0FFDFD0FFC7BFFFB8AFFFB7A0FFB8AFCCB2B2B5B8B1C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0B0B0FFD7CFFFE8E0FFF0EFFFE7DFFFD8D0FF
      D0C0FFB8AFFFB8AFCCB2B2C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0B0B0
      FFD8D0FFEFE0FFE0D0FFD7C0F0C8BFF0BFAFF0BFAFF0BFB0CCB2B2C3C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0ADADFFE7DFFFE7DFFFD8CFF0D0C0F0C7B0F0
      B8AFF0B09FF0AF9FCDABA5C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0B0B0
      F0E0DFFFDFD0FFD0C0F0C8BFF0BFAFF0B7A0F0AF9FF0A790CC988CC3C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0BCBCDDB8B0FFD8CFF0CFBFF0C7B0F0B8A0F0
      B09FF0A890EFA08FC9A6A2C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      BFB1AFCBA19BEFB8AFEFB8AFEFAF9FEFA790DD9283B5887EC0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C3C0C0B99E9BB79392B68E8DB7
      938FBFAFAFC1C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
  end
  object cmdStopServer: TBitBtn
    Left = 96
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 5
    Visible = False
    OnClick = cmdStopServerClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0B6B5C96E6ED1514CE08986D1C0C0
      C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0BFBCBCB3
      AAC04847DD0F07E00F07E0100FEF807CDBC1C1C3C0C0C0C0C0C0C0C0C0C0C0C0
      C2C0C0C0ADADC09898D0A09FD0A0A0C0B0D0201FDF0000D06067D04047DF2F28
      E07877DAC0C0C0C0C0C0C0C0C0C0C0C0B69692DEC6C0FFE8E0FFDFD0FFCFCFE0
      D8EF2F27DF0000CFDFDFF0E0E7F06060E03830ECBEBEC3C0C0C0C0C0C0C0B6B6
      EFC0BFFFE8E0FFEFEFFFDFD0F0C7C0C0B7DF4F47DF0000CFDFD8F0F0F7FF7070
      E0100FEFAFADCCC0C0C0C0C0C0C0B0B0FFD7CFFFE8E0FFEFEFFFDFD0FFC7BFC0
      A0C06060D01008CF4F48D08F88DF5F58DF0F07E0A6A4CEC0C0C0C0C0C0C0B0B0
      FFD8D0FFE8E0FFEFE0FFDFD0FFC7BFF0B0AF6F57BF2F20C00F00D00F00DF0F00
      DF1A12DDBCBCC3C0C0C0C0C0C0C0B0B0FFD8D0FFE8E0FFEFE0FFDFD0FFC7BFFF
      B8AFDF9FA0805FBF1F17D00F07D0251EDB7E7BCBC0C0C0C0C0C0C0C0C0C0B0B0
      FFD7CFFFE8E0FFEFE0FFDFD0FFC7BFFFB8AFFFB7A0FFB8AFCCABB3B1ACC0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0B0B0FFD7CFFFE8E0FFF0EFFFE7DFFFD8D0FF
      D0C0FFB8AFFFB8AFCCB2B2C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0B0B0
      FFD8D0FFEFE0FFE0D0FFD7C0F0C8BFF0BFAFF0BFAFF0BFB0CCB2B2C3C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0ADADFFE7DFFFE7DFFFD8CFF0D0C0F0C7B0F0
      B8AFF0B09FF0AF9FCDABA5C3C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0ADAD
      F0E0DFFFDFD0FFD0C0F0C8BFF0BFAFF0B7A0F0AF9FF0A790CC988CC3C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0BCBCDDB8B0FFD8CFF0CFBFF0C7B0F0B8A0F0
      B09FF0A890EFA08FB68E8DC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      BFB1AFCBA19BEFB8AFEFB8AFEFAF9FEFA790DD9283B5887EC0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C3C0C0B99E9BB79392B68E8DB7
      938FBFAFAFC1C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
  end
end