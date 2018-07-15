unit LoginUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLogin = class(TForm)
    editUserName: TEdit;
    editPassword: TEdit;
    lbl2: TLabel;
    btnLogin: TButton;
    lbl1: TLabel;
    btnReg: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

uses
  StoreUnit, RegExpr;

function judgeUserName(const UserName: WideString): Boolean;
begin
  if Length(UserName) >= 1 then
  begin
    Result := True;
  end
  else
  begin
    ShowMessage('用户名长度必须大于1');
    Result := False;
  end;
end;

function judgePassword(const password: WideString): Boolean;
begin
  if ExecRegExpr('[a-zA-Z0-9_-]{6,200}', password) then
  begin
    Result := True;
  end
  else
  begin
    ShowMessage('密码必须为6-200位的字母、数字、-、_)');
    Result := False;
  end;
end;

procedure TLogin.btnLoginClick(Sender: TObject);
var
  userName: WideString;
  password: WideString;
  lr: LoginResult;
begin
  userName := Trim(editUserName.Text);
  password := Trim(editPassword.Text);
  lr := Store.Login(userName, password);
  if lr.Ok then
  begin
    Login.ModalResult := mrOk;
  end
  else
  begin
    if lr.Error = UserNameNotExists then
    begin
      ShowMessage('用户名不存在');
    end
    else
    begin
      ShowMessage('密码错误');
    end;
  end;
end;

procedure TLogin.btnRegClick(Sender: TObject);
var
  userName: WideString;
  password: WideString;
  rr: RegResult;
begin
  userName := Trim(editUserName.Text);
  if not judgeUserName(userName) then
  begin
    Exit;
  end;
  password := Trim(editPassword.Text);
  if not judgeUserName(password) then
  begin
    Exit;
  end;
  rr := Store.Reg(userName, password);
  if rr.Ok then
  begin
    Login.ModalResult := mrOk;
  end
  else
  begin
    if rr.Error = UserNameHasExists then
    begin
      ShowMessage('用户名已存在');
    end
    else
    begin
      ShowMessage('内部数据库错误，请重试');
    end;
  end;
end;

end.

