object MainForm: TMainForm
  Left = 306
  Top = 147
  Width = 928
  Height = 494
  Caption = #29677#32423#36890#35759#24405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menu
  OldCreateOrder = False
  Visible = True
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object menu: TMainMenu
    Left = 880
    Top = 65528
    object mItemFile: TMenuItem
      Caption = 'File'
      object mItemQuitLogin: TMenuItem
        Caption = 'Quit Login'
        OnClick = mItemQuitLoginClick
      end
      object mItemQuit: TMenuItem
        Caption = 'Quit'
        OnClick = mItemQuitClick
      end
    end
    object mItemHelp: TMenuItem
      Caption = 'Help'
    end
  end
end
