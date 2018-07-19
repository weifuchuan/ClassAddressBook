object MainForm: TMainForm
  Left = 347
  Top = 136
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #29677#32423#36890#35759#24405
  ClientHeight = 602
  ClientWidth = 676
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menu1
  OldCreateOrder = False
  Visible = True
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object scrollClazzes: TScrollBox
    Left = 136
    Top = 0
    Width = 540
    Height = 601
    Color = clGradientInactiveCaption
    ParentColor = False
    TabOrder = 1
    object pnlClazzes: TPanel
      Left = 0
      Top = 0
      Width = 511
      Height = 597
      AutoSize = True
      BorderStyle = bsSingle
      Color = clGradientInactiveCaption
      TabOrder = 0
    end
  end
  object btnAddClazz: TButton
    Left = 0
    Top = 0
    Width = 137
    Height = 49
    Caption = #26032#22686#29677#32423
    TabOrder = 0
    OnClick = btnAddClazzClick
  end
  object btnAddStudent: TButton
    Left = 0
    Top = 56
    Width = 137
    Height = 49
    Caption = #26032#22686#23398#29983
    TabOrder = 2
    OnClick = btnAddStudentClick
  end
  object editSearch: TEdit
    Left = 0
    Top = 120
    Width = 137
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object groupSearchRange: TGroupBox
    Left = 0
    Top = 152
    Width = 137
    Height = 193
    Caption = #25628#32034#33539#22260
    TabOrder = 4
    object chkName: TCheckBox
      Left = 0
      Top = 24
      Width = 97
      Height = 17
      Caption = #22995#21517
      TabOrder = 0
      OnClick = chkNameClick
    end
    object chkClazz: TCheckBox
      Left = 0
      Top = 96
      Width = 97
      Height = 17
      Caption = #29677#32423
      TabOrder = 3
      OnClick = chkClazzClick
    end
    object chkAddress: TCheckBox
      Left = 0
      Top = 48
      Width = 97
      Height = 17
      Caption = #22320#22336
      TabOrder = 1
      OnClick = chkAddressClick
    end
    object chkPhone: TCheckBox
      Left = 0
      Top = 72
      Width = 97
      Height = 17
      Caption = #30005#35805
      TabOrder = 2
      OnClick = chkPhoneClick
    end
    object chkCollege: TCheckBox
      Left = 0
      Top = 120
      Width = 97
      Height = 17
      Caption = #23398#26657
      TabOrder = 4
      OnClick = chkCollegeClick
    end
    object chkAcademy: TCheckBox
      Left = 0
      Top = 144
      Width = 97
      Height = 17
      Caption = #23398#38498
      TabOrder = 5
      OnClick = chkAcademyClick
    end
    object chkProcession: TCheckBox
      Left = 0
      Top = 168
      Width = 97
      Height = 17
      Caption = #19987#19994
      TabOrder = 6
      OnClick = chkProcessionClick
    end
  end
  object btnSearch: TButton
    Left = 0
    Top = 352
    Width = 137
    Height = 49
    Caption = #25628#32034
    TabOrder = 5
    OnClick = btnSearchClick
  end
  object btnReturn: TButton
    Left = 0
    Top = 408
    Width = 137
    Height = 49
    Caption = #36824#21407
    TabOrder = 6
    OnClick = btnReturnClick
  end
  object menu1: TMainMenu
    Left = 8
    Top = 568
    object mItemFile1: TMenuItem
      Caption = 'File'
      object mItemN1: TMenuItem
        Caption = #36864#20986#30331#24405
        OnClick = mItemQuitLoginClick
      end
      object mItemN2: TMenuItem
        Caption = #36864#20986
        OnClick = mItemQuitClick
      end
    end
    object mItemHelp1: TMenuItem
      Caption = 'Help'
    end
  end
end
