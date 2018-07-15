program ClassAddressBook;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  LoginUnit in 'LoginUnit.pas' {Login},
  StoreUnit in 'StoreUnit.pas',
  RegExpr in 'RegExpr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLogin, Login);
  Application.Run;
end.
