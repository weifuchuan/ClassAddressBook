unit StudentFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StudentUnit, Menus;

type
//  TOnEdited = procedure of object;

  TStudentFrame = class(TFrame)
    labelName: TLabel;
    label2: TLabel;
    label3: TLabel;
    labelPhone: TLabel;
    label4: TLabel;
    scrlbx1: TScrollBox;
    labelAddress: TLabel;
    pmEdit: TPopupMenu;
    Edit: TMenuItem;
    N2: TMenuItem;
    procedure EditClick(Sender: TObject);
  private
    student: TStudent;
  public
    OnEdited: procedure of object;
    procedure Init(student: TStudent);
  end;

implementation

{$R *.dfm}

uses
  EditFormUnit, StoreUnit;

procedure TStudentFrame.Init(student: TStudent);
begin
  self.student := student;
  labelName.Caption := student.Name;
  labelPhone.Caption := student.Phone;
  labelAddress.Caption := student.Address;
end;

procedure TStudentFrame.EditClick(Sender: TObject);
var
  r: TModalResult;
begin
  Store.willEditStudent := Self.student;
  r := EditForm.ShowModal;
  if r = mrOk then
  begin
    if Assigned(Self.OnEdited) then
    begin
      self.OnEdited;
    end;
  end
  else if r = mrCancel then
  begin

  end;
end;

end.

