object frmColumnSelection: TfrmColumnSelection
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Sele'#231#227'o de Colunas'
  ClientHeight = 266
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 228
    Width = 443
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pnlButtons: TPanel
      Left = 251
      Top = 0
      Width = 192
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object cmdOk: TBitBtn
        Left = 16
        Top = 8
        Width = 81
        Height = 25
        Caption = '&OK'
        DoubleBuffered = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0066001EB2311FB13300
          6600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00660031C24F22B7381AB02D21B437006600FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF00660047D36D3BCB5E25A83B0066001B
          A92E1DB132006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600
          4FD67953DE7F31B54D006600FF00FF006600179D271EAE31006600FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF00660041C563006600FF00FFFF00FFFF
          00FFFF00FF00660019AA2B006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600149D210066
          00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF006600006600FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = cmdOkClick
      end
      object cmdCancel: TBitBtn
        Left = 104
        Top = 8
        Width = 81
        Height = 25
        Cancel = True
        Caption = '&Cancelar'
        DoubleBuffered = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4B4BCBF8C91947377796F73757A7E819CA2A5C3CBCFC8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C6CED272768723246504046200
          006500006000004F1112394D5052A6ADB0C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          BFC7CB4C4F8100008400008E00008E00008F00008C000088000081010154292A
          34989EA1C8D0D4C8D0D4C8D0D4C6CED2484A8B00009600009700009B00009F00
          00A000009D00009700008F0000880000622A2C36A8AFB2C8D0D4C8D0D47075A0
          0101A308089E9999D46868D00000AC0000AE0000A94848B8B7B7E32727A50000
          8C010152595C5EC8D0D4ADB4CB2122A60000AB2828A3DEDED2FEFEFF6464D400
          00B34646C0E7E7ECFFFFF75E5EB700009A02028724273EC8D0D4777BCD0707B1
          0303B90000C24C4CA7E6E6D9FCFCFF9E9EE6E8E9F4FFFFF17575B90606B10101
          AB0202A00F115AC8D0D4474AC30808BB0707C80505D10000C85353B6F2F2EDFF
          FFFFFFFFFC7575C90000BE0101C30303B80303AC0D0E6DC8D0D43D3FC80C0CC9
          0D0DD80B0BDC0000D63C3DCEEEEFEDFFFFFFFFFFFD5858DB0000CA0303CB0606
          C50606B80F0F77C8D0D45B5ED41414D81717EA0B0BF14343DBE4E4EAFDFDF5BA
          BAD4EAEAE8FEFEFF6363E50303D70A0ACF0A0AC31B1C7AC8D0D4949AD82324E3
          2222FB3F3FE9DCDCE5FDFDEE7373C50303D75151B0E3E3D6FFFFFE6161E50808
          DB0F0FCA3F4279C8D0D4BFC6D54D4FE53232FF5252EDB3B3C27777CA0000EA00
          00EC0000E85252B4ADADB04D4DE11818ED1616AF8F949BC8D0D4C8D0D4A9B0D9
          393AF75353FF6868EF5757F93838FF2525FD2929FF3838FC4242EB3232FF1F1F
          E9636793C8D0D4C8D0D4C8D0D4C8D0D4999FDC4444F96E6EFF9191FF9393FF84
          84FF7676FF6767FF5151FF3131FB6266A0C7CFD3C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4ADB4D95C5FF06767FC8787FF9292FF7676FF5353FF4749EB8388B3C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4BFC6D6979CDE7275EA71
          73F36C6FEC878CE3B1B9D3C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4}
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = cmdCancelClick
      end
    end
    object cmdSave: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = cmdSaveClick
    end
  end
  object chklstColumns: TCheckListBox
    Left = 0
    Top = 0
    Width = 408
    Height = 228
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object pnlRight: TPanel
    Left = 408
    Top = 0
    Width = 35
    Height = 228
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object cmdSelectAll: TBitBtn
      Left = 6
      Top = 8
      Width = 23
      Height = 23
      Hint = 'Seleciona todos'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FF800000
        800000800000800000800000800000800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FF000000FF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FF000000FF00FF000000FF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FF000000800000FF00FF8000008000008000008000
        00800000800000800000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF800000
        800000800000800000800000800000800000FF00FF800000FF00FFFF00FF0000
        00FF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF800000FF00FF000000FF00FF000000FF00FF800000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00
        FFFF00FF000000800000FF00FF80000080000080000080000080000080000080
        0000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF8000008000008000008000
        00800000800000800000FF00FF800000FF00FFFF00FF000000FF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FF000000FF00FF000000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FF00000080
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF80000080000080000080000080000080000080
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdSelectAllClick
    end
    object cmdUnselectAll: TBitBtn
      Left = 6
      Top = 33
      Width = 23
      Height = 23
      Hint = 'Desseleciona todos'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FF800000
        800000800000800000800000800000800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF8000008000008000008000
        00800000800000800000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF800000
        800000800000800000800000800000800000FF00FF800000FF00FFFF00FFFF00
        FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00
        FFFF00FFFF00FF800000FF00FF80000080000080000080000080000080000080
        0000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FF8000008000008000008000
        00800000800000800000FF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00FF80
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000
        FF00FFFF00FFFF00FFFF00FFFF00FF800000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF80000080000080000080000080000080000080
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cmdUnselectAllClick
    end
    object cmdMoveUp: TBitBtn
      Left = 6
      Top = 62
      Width = 23
      Height = 23
      Hint = 'Mover para cima'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF044906055B09066C0C066C0C055E0A044C06FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF05600905600908911309B01809
        B31A09B31909B11907961405680C05680CFF00FFFF00FFFF00FFFF00FFFF00FF
        0A6A150A7F150BB61C09B91A08B41807B21609B31909B41909B81A09B91A0783
        10044D06FF00FFFF00FFFF00FF0B6A150F852216BD3411B7270BB21C07B116C2
        ECC6FFFFFF50C85C09B21909B41909BA1A07841006670CFF00FFFF00FF0B6A15
        20BE491BBD4014B7300AB21F09B219C0EBC4FFFFFF51C95D09B21909B21909B3
        1909BA1A06670CFF00FF0872101B9A3A2AC65B1DBB450EB4250BB31B09B21ABF
        EBC3FFFFFF50C85C09B21909B21909B21909B81A089413045D090872102AB65B
        2CC56522BD4D2DBD3E12B4210CB31CC0EBC3FFFFFF50C85C09B2192ABC3817B6
        2609B51A08AB17045D090F821C37C26C33C76C36C56AE4F7E9A5E4B52AC053C5
        EED0FFFFFF41C34D4FC85AF5FCF6ADE5B208B41909B31905650B138D2358CC83
        42C97737C56EF1FBF5FFFFFFA3E5BDCBF0DAFFFFFF85D98EE4F7E6FFFFFF97DE
        9E0AB41A09B319066D0D0F911D6FD2935FD38D31C36980DAA3F9FDFAFDFFFEF9
        FDFBFDFEFEFBFEFBFFFFFF95DEA41DB93D11B82B08B11905610A0F911D67CC83
        9BE5BA38C67030C3697AD89EF8FDFAFFFFFFFFFFFFFFFFFF9FE2B120BD481AB9
        3E10BA2908A31705610AFF00FF37B650BCEDD282DBA428C0632FC26778D89DF5
        FCF8FFFFFFB1E8C322BC4B1DBA4118B73614C0300A8517FF00FFFF00FF37B650
        71D28CD2F4E180DAA336C46D2DC2678ADDAAC9EFD83DC76F24BE5623BC4D1FC1
        4616AE340A8517FF00FFFF00FFFF00FF25AE3984D89FDBF7EAAFE8C66BD49352
        CC8144C97849CA7B48CB7839CB6A21B6490F7C1FFF00FFFF00FFFF00FFFF00FF
        FF00FF66CD8166CD81ADE8C5CCF2DEBAEDD1A6E7C291E2B364D4922FB1572FB1
        57FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32B74E52C46F61
        CB805DC87D43B96424A342FF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = cmdMoveUpClick
    end
    object cmdMoveDown: TBitBtn
      Left = 6
      Top = 86
      Width = 23
      Height = 23
      Hint = 'Mover para baixo'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF044906055B09066C0C066C0C055E0A044C06FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF05600905600908911309B01809
        B31A09B31909B11907961405680C05680CFF00FFFF00FFFF00FFFF00FFFF00FF
        0A6A150A7F150BB61C09B91A08B41807B21609B31909B41909B81A09B91A0783
        10044D06FF00FFFF00FFFF00FF0B6A150F852216BD3411B7270BB21C07B1166F
        D177BCEAC120B92F09B21909B41909BA1A07841006670CFF00FFFF00FF0B6A15
        20BE491BBD4014B7300AB21F58CB63F2FBF3FFFFFFA6E3AC0BB31B09B21909B3
        1909BA1A06670CFF00FF0872101B9A3A2AC65B1DBB450EB4255BCC66F6FCF7FF
        FFFFFFFFFFFFFFFF96DE9D0BB31B09B21909B81A089413045D090872102AB65B
        2CC56522BD4D67CF73F7FDF8FDFEFDF8FDF9FDFEFDFAFDFAFFFFFF8EDC950EB4
        1E09B51A08AB17045D090F821C37C26C33C76C36C56AF0FAF3FFFFFF9CE2AFC7
        EED2FFFFFF83D88BE4F7E6FFFFFF97DE9E08B41909B31905650B138D2358CC83
        42C97737C56EE6F8EDADE8C438C670C9F0D9FFFFFF44C5514FC85CF5FCF6ADE5
        B20AB41A09B319066D0D0F911D6FD2935FD38D31C36950CC803DC77338C56FCA
        F0D8FFFFFF5CCE761AB93E37C15325BC4411B82B08B11905610A0F911D67CC83
        9BE5BA38C67030C36938C56F38C56FCBF0D9FFFFFF61D0811EBC491EBC471AB9
        3E10BA2908A31705610AFF00FF37B650BCEDD282DBA428C0632FC26738C56FCC
        F0DAFFFFFF67D28920BB4A1DBA4118B73614C0300A8517FF00FFFF00FF37B650
        71D28CD2F4E180DAA336C46D2DC267CDF1DBFFFFFF67D38E24BE5623BC4D1FC1
        4616AE340A8517FF00FFFF00FFFF00FF25AE3984D89FDBF7EAAFE8C66BD49352
        CC8144C97849CA7B48CB7839CB6A21B6490F7C1FFF00FFFF00FFFF00FFFF00FF
        FF00FF66CD8166CD81ADE8C5CCF2DEBAEDD1A6E7C291E2B364D4922FB1572FB1
        57FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32B74E52C46F61
        CB805DC87D43B96424A342FF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = cmdMoveDownClick
    end
  end
end
