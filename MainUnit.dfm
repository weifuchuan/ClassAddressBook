object MainForm: TMainForm
  Left = 355
  Top = 67
  Width = 692
  Height = 660
  Caption = #29677#32423#36890#35759#24405
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
    TabOrder = 0
    object pnlClazzes: TPanel
      Left = 0
      Top = 0
      Width = 511
      Height = 597
      AutoSize = True
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
    TabOrder = 1
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
