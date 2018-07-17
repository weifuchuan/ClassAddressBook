unit MainUnit;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, Buttons, ExtCtrls, ComCtrls, StoreUnit;

type
  TMainForm = class(TForm)
    scrollClazzes: TScrollBox;
    pnlClazzes: TPanel;
    menu1: TMainMenu;
    mItemFile1: TMenuItem;
    mItemN1: TMenuItem;
    mItemN2: TMenuItem;
    mItemHelp1: TMenuItem;
    btnAddClazz: TButton;
    btnAddStudent: TButton;
    procedure mItemQuitClick(Sender: TObject);
    procedure mItemQuitLoginClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnAddClazzClick(Sender: TObject);
    procedure btnAddStudentClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Login;
    procedure Refresh;
    procedure Clear;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  LoginUnit, StudentFrameUnit, UserUnit, StudentUnit, ClazzFrameUnit, ClazzUnit,
  EditClazzUnit, EditStudentUnit;

var
  count: integer;

function Counter: integer;
begin
  count := count + 1;
  result := count;
end;

procedure TMainForm.mItemQuitClick(Sender: TObject);
begin
  MainForm.Close;
end;

procedure TMainForm.mItemQuitLoginClick(Sender: TObject);
begin
  Self.Clear;
  Store.Quit;
  self.Login;
end;

procedure TMainForm.Clear;
var
  i: Integer;
  cs: array of TControl;
begin
  SetLength(cs, self.pnlClazzes.ControlCount);
  for i := 0 to self.pnlClazzes.ControlCount - 1 do
  begin
    cs[i] := self.pnlClazzes.Controls[i];
  end;
  for i := 0 to Length(cs) - 1 do
  begin
    self.pnlClazzes.RemoveControl(cs[i]);
  end;
end;

procedure TMainForm.Login;
begin
  if LoginForm.ShowModal = mrOk then
  begin
    self.Refresh;
  end;
end;

procedure TMainForm.Refresh;
var
  clzs: TClazzList;
  stds: TStudentList;
  cf: TframeClazz;
  top: Integer;
  i: integer;
begin
  Self.Clear;
  SetLength(clzs, 0);
  SetLength(stds, 0);
  top := 5;
  clzs := ClazzDao.FindAll;
  for i := 0 to Length(clzs) - 1 do
  begin
    cf := TframeClazz.Create(self);
    cf.Name := 'frameClazz' + IntToStr(Counter);
    cf.OnEdited := Self.Refresh;
    cf.OnDeleted := Self.Refresh;
    cf.OnStudentEdited := Self.Refresh;
    cf.OnStudentDeleted := Self.Refresh;
    stds := StudentDao.FindByCLazzId(clzs[i].id);
    self.pnlClazzes.InsertControl(cf);
    cf.Init(clzs[i], stds);
    cf.Top := top;
    cf.Left := 0;
    top := top + cf.Height + 5;
  end;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  if not Store.Loged then
  begin
    self.Login;
  end;
end;

procedure TMainForm.btnAddClazzClick(Sender: TObject);
var
  clz: TClazz;
begin
  clz := TClazz.Create;
  clz.UserId := Store.MyId;
  Store.willEditClazz := clz;
  if FrmEditClazz.ShowModal = mrOk then
  begin
    self.Refresh;
  end;
end;

procedure TMainForm.btnAddStudentClick(Sender: TObject);
var
  std: TStudent;
begin
  std := TStudent.Create;
  std.UserId := Store.MyId;
  Store.willEditStudent := std;
  if EditStudent.ShowModal = mrOK then
  begin
    self.Refresh;
  end;
end;

end.

