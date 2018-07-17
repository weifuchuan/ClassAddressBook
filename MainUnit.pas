unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Buttons, ExtCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    scrollClazzes: TScrollBox;
    pnlClazzes: TPanel;
    procedure FormPaint(Sender: TObject);
    procedure mItemQuitClick(Sender: TObject);
    procedure mItemQuitLoginClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  StoreUnit, LoginUnit, StudentFrameUnit, UserUnit, StudentUnit, ClazzFrameUnit,
  ClazzUnit;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  if not Store.Loged then
  begin
    Login.ShowModal;
  end;
end;

procedure TMainForm.mItemQuitClick(Sender: TObject);
begin
  MainForm.Close;
end;

procedure TMainForm.mItemQuitLoginClick(Sender: TObject);
begin
  Store.Quit;
  Login.ShowModal;
end;



end.

