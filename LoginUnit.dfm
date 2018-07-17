object LoginForm: TLoginForm
  Left = 438
  Top = 281
  Width = 347
  Height = 156
  BorderIcons = []
  Caption = #30331#24405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 32
    Top = 56
    Width = 36
    Height = 16
    Caption = #23494#30721#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 16
    Top = 24
    Width = 48
    Height = 16
    Caption = #29992#25143#21517#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object editUserName: TEdit
    Left = 84
    Top = 16
    Width = 225
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object editPassword: TEdit
    Left = 84
    Top = 48
    Width = 225
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnLogin: TButton
    Left = 144
    Top = 80
    Width = 75
    Height = 25
    Caption = #30331#24405
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnReg: TButton
    Left = 232
    Top = 80
    Width = 75
    Height = 25
    Caption = #27880#20876
    TabOrder = 3
    OnClick = btnRegClick
  end
end
