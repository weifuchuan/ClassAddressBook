unit MainUnit;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, Buttons, ExtCtrls, ComCtrls, StoreUnit, ADODB;

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
    editSearch: TEdit;
    groupSearchRange: TGroupBox;
    chkName: TCheckBox;
    chkClazz: TCheckBox;
    chkAddress: TCheckBox;
    chkPhone: TCheckBox;
    chkCollege: TCheckBox;
    chkAcademy: TCheckBox;
    chkProcession: TCheckBox;
    btnSearch: TButton;
    btnReturn: TButton;
    procedure mItemQuitClick(Sender: TObject);
    procedure mItemQuitLoginClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnAddClazzClick(Sender: TObject);
    procedure btnAddStudentClick(Sender: TObject);
    procedure chkNameClick(Sender: TObject);
    procedure chkAddressClick(Sender: TObject);
    procedure chkPhoneClick(Sender: TObject);
    procedure chkClazzClick(Sender: TObject);
    procedure chkCollegeClick(Sender: TObject);
    procedure chkAcademyClick(Sender: TObject);
    procedure chkProcessionClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
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
  EditClazzUnit, EditStudentUnit, StrUtils;

var
  count: integer;

function Counter: integer;
begin
  count := count + 1;
  result := count;
end;

procedure ShowClazzes(clzs: TClazzList); overload;
var
  stds: TStudentList;
  cf: TframeClazz;
  top: Integer;
  i: integer;
begin
  MainForm.Clear;
  SetLength(stds, 0);
  top := 5;
  for i := 0 to Length(clzs) - 1 do
  begin
    cf := TframeClazz.Create(MainForm);
    cf.Name := 'frameClazz' + IntToStr(Counter);
    cf.OnEdited := MainForm.Refresh;
    cf.OnDeleted := MainForm.Refresh;
    cf.OnStudentEdited := MainForm.Refresh;
    cf.OnStudentDeleted := MainForm.Refresh;
    stds := StudentDao.FindByCLazzId(clzs[i].id);
    MainForm.pnlClazzes.InsertControl(cf);
    cf.Init(clzs[i], stds);
    cf.Top := top;
    cf.Left := 0;
    top := top + cf.Height + 5;
  end;
end;

procedure ShowClazzes(clzs: TClazzList; stds: TStudentList); overload;
var
  cf: TframeClazz;
  top: Integer;
  i: integer;
  j: Integer;
  k: Integer;
  sOfC: TStudentList;
begin
  MainForm.Clear;
  top := 5;
  for i := 0 to Length(clzs) - 1 do
  begin
    j := 0;
    SetLength(sOfC, 0);
    for k := 0 to Length(stds) - 1 do
    begin
      if stds[k].ClazzId = clzs[i].Id then
      begin
        j := j + 1;
        SetLength(sOfC, j);
        sOfC[j - 1] := stds[k];
      end;
    end;
    cf := TframeClazz.Create(MainForm);
    cf.Name := 'frameClazz' + IntToStr(Counter);
    cf.OnEdited := MainForm.Refresh;
    cf.OnDeleted := MainForm.Refresh;
    cf.OnStudentEdited := MainForm.Refresh;
    cf.OnStudentDeleted := MainForm.Refresh;
    MainForm.pnlClazzes.InsertControl(cf);
    cf.Init(clzs[i], sOfC);
    cf.Top := top;
    cf.Left := 0;
    top := top + cf.Height + 5;
  end;
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
begin
  SetLength(clzs, 0);
  clzs := ClazzDao.FindAll;
  ShowClazzes(clzs);
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

type
//  TStrSet = (name, address, phone, clazz, college, academy, profession);
  TStrSet = set of'a'..'z';

var
  searchRange: TStrSet = [];

procedure TMainForm.chkNameClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['n']
  else
    searchRange := searchRange - ['n'];
end;

procedure TMainForm.chkAddressClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['a']
  else
    searchRange := searchRange - ['a'];
end;

procedure TMainForm.chkPhoneClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['p']
  else
    searchRange := searchRange - ['p'];
end;

procedure TMainForm.chkClazzClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['c']
  else
    searchRange := searchRange - ['c'];
end;

procedure TMainForm.chkCollegeClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['o']
  else
    searchRange := searchRange - ['o'];
end;

procedure TMainForm.chkAcademyClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['d']
  else
    searchRange := searchRange - ['d'];
end;

procedure TMainForm.chkProcessionClick(Sender: TObject);
begin
  if chkName.Checked then
    searchRange := searchRange + ['r']
  else
    searchRange := searchRange - ['r'];
end;

procedure TMainForm.btnReturnClick(Sender: TObject);
begin
  self.Refresh;
end;

function contain(arr: array of Integer; v: Integer): Boolean;
var
  i: Integer;
begin
  for i := 0 to Length(arr) - 1 do
  begin
    if arr[i] = v then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

//  TStrSet = (name, address, phone, clazz, college, academy, profession);
procedure TMainForm.btnSearchClick(Sender: TObject);
var
  str: WideString;
  cons: array of string;
  cnt: Integer;
  i: Integer;
  j: Integer;
  query: TADOQuery;
  where: WideString;
  ids: array of Integer;
  cids: array of Integer;
  students: TStudentList;
  clazzes: TClazzList;
begin
  SetLength(students, 0);
  SetLength(clazzes, 0);
  cnt := 0;
  str := editSearch.Text;
  if Length(trim(str)) = 0 then
  begin
    exit;
  end;
  for i := 0 to Length(str) - 1 do
  begin
    if str[i] = ' ' then
      str[i] := '%';
  end;
  if 'n' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' s.studentName like ''%' + str + '%'' ';
  end;
  if 'a' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' s.address like ''%' + str + '%'' ';
  end;
  if 'p' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' s.phone like ''%' + str + '%'' ';
  end;
  if 'c' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' c.briefName like ''%' + str + '%'' ';
  end;
  if 'o' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' c.college like ''%' + str + '%'' ';
  end;
  if 'd' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' c.academy like ''%' + str + '%'' ';
  end;
  if 'r' in searchRange then
  begin
    cnt := cnt + 1;
    SetLength(cons, cnt);
    cons[cnt - 1] := ' c.profession like ''%' + str + '%'' ';
  end;
  where := '';
  for i := 0 to Length(cons) - 1 do
  begin
    where := where + ' or ' + cons[i];
  end;
  where := rightStr(where, Length(where) - 3);
  query := TADOQuery.Create(nil);
  query.Connection := Store.Conn;
  with query do
  begin
    SQL.Text := 'select DISTINCT s.ID as id from student s, clazz c where ' + where;
    Open;
    SetLength(ids, RecordCount);
    for i := 0 to RecordCount - 1 do
    begin
      ids[i] := fieldbyname('id').AsInteger;
      Next;
    end;
    Close;
    SetLength(students, Length(ids));
    j := 0;
    SetLength(cids, j);
    SetLength(clazzes, j);
    for i := 0 to Length(ids) - 1 do
    begin
      SQL.Text := 'select * from student where ID=:id';
      Parameters.ParamByName('id').Value := ids[i];
      Open;
      students[i] := TStudent.from(query);
      Close;
      if not contain(cids, students[i].ClazzId) then
      begin
        j := j + 1;
        SetLength(cids, j);
        SetLength(clazzes, j);
        cids[j - 1] := students[i].ClazzId;
        SQL.Text := 'select * from clazz where ID=:id';
        Parameters.ParamByName('id').Value := students[i].ClazzId;
        Open;
        clazzes[j - 1] := TClazz.from(query);
        Close;
      end;
    end;
    ShowClazzes(clazzes, students);
  end;
end;

end.

