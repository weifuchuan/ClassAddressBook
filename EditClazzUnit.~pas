unit EditClazzUnit;

interface

uses
  ShareMem, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ClazzUnit;

type
  TFrmEditClazz = class(TForm)
    lbledtAcademy: TLabeledEdit;
    lbledtCollege: TLabeledEdit;
    lbledtProfession: TLabeledEdit;
    lbledtGrade: TLabeledEdit;
    lbledtClazzNumber: TLabeledEdit;
    lbledtBriefName: TLabeledEdit;
    btnSave: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    clazz: TClazz;
  public
    { Public declarations }
  end;

var
  FrmEditClazz: TFrmEditClazz;

implementation

{$R *.dfm}

uses
  StoreUnit;

procedure TFrmEditClazz.FormShow(Sender: TObject);
begin
  self.clazz := Store.willEditClazz as TClazz;
  with self.clazz do
  begin
    lbledtBriefName.Text := BriefName;
    lbledtAcademy.Text := Academy;
    lbledtCollege.Text := College;
    lbledtProfession.Text := Profession;
    lbledtGrade.Text := Grade;
    lbledtClazzNumber.Text := ClazzNumber;
  end;
end;

procedure TFrmEditClazz.btnSaveClick(Sender: TObject);
begin
  with self.clazz do
  begin
    BriefName := lbledtBriefName.Text;
    Academy := lbledtAcademy.Text;
    College := lbledtCollege.Text;
    Profession := lbledtProfession.Text;
    Grade := lbledtGrade.Text;
    ClazzNumber := lbledtClazzNumber.Text;
  end;
  try
    ClazzDao.Save(Self.clazz);
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      exit;
    end;
  end;
  Self.ModalResult := mrOk;
end;

procedure TFrmEditClazz.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.

