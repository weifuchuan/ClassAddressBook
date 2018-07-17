program ClassAddressBook;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  LoginUnit in 'LoginUnit.pas' {Login},
  StoreUnit in 'StoreUnit.pas',
  RegExpr in 'RegExpr.pas',
  StudentFrameUnit in 'StudentFrameUnit.pas' {StudentFrame: TFrame},
  StudentUnit in 'StudentUnit.pas',
  ClazzUnit in 'ClazzUnit.pas',
  UserUnit in 'UserUnit.pas',
  ExceptionsUnit in 'ExceptionsUnit.pas',
  ClazzFrameUnit in 'ClazzFrameUnit.pas' {frameClazz: TFrame},
  EditFormUnit in 'EditFormUnit.pas' {EditForm},
  EventEmitterUnit in 'EventEmitterUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TEditForm, EditForm);
  Application.Run;
end.
