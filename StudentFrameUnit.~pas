unit StudentFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StudentUnit;

type
  TStudentFrame = class(TFrame)
    labelName: TLabel;
    label2: TLabel;
    label3: TLabel;
    labelPhone: TLabel;
    label4: TLabel;
    scrlbx1: TScrollBox;
    labelAddress: TLabel;
  private
    student: TStudent;
  public
    procedure Init(student: TStudent);
  end;

implementation

{$R *.dfm}

procedure TStudentFrame.Init(student: TStudent);
begin
  self.student := student;
  labelName.Caption := student.Name;
  labelPhone.Caption := student.Phone;
  labelAddress.Caption := student.Address;
end;

end.

