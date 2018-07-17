program ClassAddressBook;

uses
  ShareMem,
  Forms,
  StoreUnit in 'StoreUnit.pas',
  MainUnit in 'MainUnit.pas' {MainForm},
  LoginUnit in 'LoginUnit.pas' {LoginForm},
  RegExpr in 'RegExpr.pas',
  StudentFrameUnit in 'StudentFrameUnit.pas' {StudentFrame: TFrame},
  StudentUnit in 'StudentUnit.pas',
  ClazzUnit in 'ClazzUnit.pas',
  UserUnit in 'UserUnit.pas',
  ExceptionsUnit in 'ExceptionsUnit.pas',
  ClazzFrameUnit in 'ClazzFrameUnit.pas' {frameClazz: TFrame},
  EditClazzUnit in 'EditClazzUnit.pas' {FrmEditClazz},
  EditStudentUnit in 'EditStudentUnit.pas' {EditStudent};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TFrmEditClazz, FrmEditClazz);
  Application.CreateForm(TEditStudent, EditStudent);
  Application.Run;
end.

