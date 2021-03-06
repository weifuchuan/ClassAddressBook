unit StudentFrameUnit;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, StudentUnit, Menus, Buttons;

type
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
    mItemDelete: TMenuItem;
    btnEdit: TSpeedButton;
    btnDelete: TSpeedButton;
    procedure EditClick(Sender: TObject);
    procedure mItemDeleteClick(Sender: TObject);
  private
    student: TStudent;
  public
    OnEdited: procedure of object;
    OnDeleted: procedure of object;
    procedure Init(student: TStudent);
  end;

implementation

{$R *.dfm}

uses
  EditStudentFormUnit, StoreUnit, EditStudentUnit;

procedure TStudentFrame.Init(student: TStudent);
begin
  self.student := student;
  labelName.Caption := student.Name;
  labelPhone.Caption := student.Phone;
  labelAddress.Caption := student.Address;
end;

procedure TStudentFrame.EditClick(Sender: TObject);
begin
  Store.willEditStudent := Self.student;
  if EditStudent.ShowModal = idOK then
  begin
    if Assigned(Self.OnEdited) then
    begin
      self.OnEdited;
    end;
  end;
end;

procedure TStudentFrame.mItemDeleteClick(Sender: TObject);
begin
  with Application do
  begin
    if MessageBox('ȷ��ɾ��ѧ����', 'ɾ��', MB_OKCANCEL) = IDOK then
    begin
      try
        StudentDao.Delete(Self.student);
      except
        on E: Exception do
        begin
          ShowMessage(E.Message);
          exit;
        end;
      end;
      if Assigned(self.OnDeleted) then
        self.OnDeleted;
    end;
  end;
end;

end.

