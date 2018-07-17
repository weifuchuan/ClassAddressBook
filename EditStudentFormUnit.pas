unit EditStudentFormUnit;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TEditStudentForm = class(TForm)
    lbl1: TLabel;
    editName: TEdit;
    lbl2: TLabel;
    editPhone: TEdit;
    lbl3: TLabel;
    editAddress: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    lbl4: TLabel;
    cbbClazzes: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    student: TObject;
    clazzes: Variant;
  public
    { Public declarations }
  end;

var
  EditStudentForm: TEditStudentForm;

implementation

{$R *.dfm}

uses
  StoreUnit, StudentUnit, ClazzUnit;

procedure TEditStudentForm.FormShow(Sender: TObject);
var
  clazzes: TClazzList;
  i: Integer;
begin
  self.student := Store.willEditStudent;
  with Store.willEditStudent as TStudent do
  begin
    self.editName.Text := Name;
    self.editPhone.Text := Phone;
    self.editAddress.Text := Address;
    clazzes := ClazzDao.FindAll;
    Self.clazzes := clazzes;
    with Self.cbbClazzes.Items do
    begin
      Clear;
      for i := 0 to Length(clazzes) - 1 do
      begin
        Add(clazzes[i].BriefName);
      end;
    end;

  end;
end;

procedure TEditStudentForm.btnSaveClick(Sender: TObject);
var
  s: TStudent;
  cs: TClazzList;
begin
  s := self.student as TStudent;
  cs := TCLazzList(self.clazzes);
  s.Name := Trim(Self.editName.Text);
  s.Phone := Trim(self.editPhone.Text);
  s.Address := Trim(Self.editAddress.Text);
  if Self.cbbClazzes.ItemIndex = -1 then
  begin
    ShowMessage('«Î—°‘Ò∞‡º∂');
    Exit;
  end;
  s.ClazzId := cs[Self.cbbClazzes.ItemIndex].Id;
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

procedure TEditStudentForm.btnCancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

end.

