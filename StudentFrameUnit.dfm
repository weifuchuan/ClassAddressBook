object StudentFrame: TStudentFrame
  Left = 0
  Top = 0
  Width = 337
  Height = 106
  Align = alCustom
  Color = clInactiveCaption
  ParentColor = False
  TabOrder = 0
  object labelName: TLabel
    Left = 48
    Top = 8
    Width = 56
    Height = 16
    Caption = 'labelName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object label2: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 13
    Caption = #22995#21517#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object label3: TLabel
    Left = 8
    Top = 32
    Width = 36
    Height = 13
    Caption = #30005#35805#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelPhone: TLabel
    Left = 48
    Top = 32
    Width = 59
    Height = 16
    Caption = 'labelPhone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object label4: TLabel
    Left = 8
    Top = 56
    Width = 36
    Height = 13
    Caption = #22320#22336#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnEdit: TSpeedButton
    Left = 288
    Top = 0
    Width = 23
    Height = 22
    Caption = 'U'
    OnClick = EditClick
  end
  object btnDelete: TSpeedButton
    Left = 313
    Top = 0
    Width = 23
    Height = 22
    Caption = 'D'
    OnClick = mItemDeleteClick
  end
  object scrlbx1: TScrollBox
    Left = 48
    Top = 56
    Width = 281
    Height = 41
    TabOrder = 0
    object labelAddress: TLabel
      Left = 0
      Top = 0
      Width = 60
      Height = 13
      Caption = 'labelAddress'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object pmEdit: TPopupMenu
    object Edit: TMenuItem
      Caption = #32534#36753
      OnClick = EditClick
    end
    object mItemDelete: TMenuItem
      Caption = #21024#38500
      OnClick = mItemDeleteClick
    end
  end
end
