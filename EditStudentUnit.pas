unit EditStudentUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEditStudent = class(TForm)
    labellbl1: TLabel;
    labellbl2: TLabel;
    labellbl3: TLabel;
    labellbl4: TLabel;
    editName: TEdit;
    editPhone: TEdit;
    editAddress: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    cbbClazzes: TComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    student: TObject;
    clazzIds: array of Integer;
  public
    { Public declarations }
  end;

var
  EditStudent: TEditStudent;

implementation

{$R *.dfm}

uses
  StoreUnit, StudentUnit, ClazzUnit;

type
  PTClazzList = ^TCLazzList;

procedure TEditStudent.btnSaveClick(Sender: TObject);
var
  s: TStudent;
begin
  s := self.student as TStudent;
  s.Name := Trim(Self.editName.Text);
  s.Phone := Trim(self.editPhone.Text);
  s.Address := Trim(Self.editAddress.Text);
  if Self.cbbClazzes.ItemIndex = -1 then
  begin
    ShowMessage('��ѡ��༶');
    Exit;
  end;
  s.ClazzId := Self.clazzIds[Self.cbbClazzes.ItemIndex];
  try
    StudentDao.Save(s);
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Exit;
    end;
  end;
  self.ModalResult := mrOk;
end;

procedure TEditStudent.FormShow(Sender: TObject);
var
  clazzes: TClazzList;
  i: Integer;
  student: TStudent;
begin
  self.student := Store.willEditStudent;
  student := self.student as TStudent;
  with student do
  begin
    self.editName.Text := Name;
    self.editPhone.Text := Phone;
    self.editAddress.Text := Address;
    clazzes := ClazzDao.FindAll;
    SetLength(self.clazzIds, Length(clazzes));
    with Self.cbbClazzes.Items do
    begin
      Clear;
      for i := 0 to Length(clazzes) - 1 do
      begin
        Add(clazzes[i].BriefName);
        self.clazzIds[i] := clazzes[i].Id;
      end;
    end;

  end;
end;

procedure TEditStudent.btnCancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

end.

