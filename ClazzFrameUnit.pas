unit ClazzFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StudentFrameUnit, ClazzUnit, StudentUnit, ExtCtrls, StdCtrls;

type
  TframeClazz = class(TFrame)
    grp: TGroupBox;
    scrlbxStudents: TScrollBox;
    panelStudents: TPanel;
  private
    clazz: TClazz;
    students: TStudentList;
  public
    procedure Init(clz: TClazz; stdnts: TStudentList);
    procedure Clear;
  end;

implementation

{$R *.dfm}

procedure TframeClazz.Init(clz: TClazz; stdnts: TStudentList);
var
  studentFrame: TStudentFrame;
  i: Integer;
  top: Integer;
begin
  self.Clear;
  top := 5;
  self.clazz := clz;
  self.students := stdnts;
  self.grp.Caption := clz.BriefName;
  for i := 0 to Length(stdnts) - 1 do
  begin
    studentFrame := TStudentFrame.Create(Self);
    studentFrame.Name := 'studentFrame' + IntToStr(i);
    studentFrame.Init(stdnts[i]);
    studentFrame.Left := 5;
    studentFrame.Top := top;
//    studentFrame.OnEdited:=
    top := top + studentFrame.Height + 5;
    Self.panelStudents.InsertControl(studentFrame);
  end;
end;

procedure TframeClazz.Clear;
var
  i: Integer;
  ctrl: TControl;
begin
  self.clazz := nil;
  Self.students := nil;
  with self.panelStudents do
  begin
    for i := 0 to ControlCount - 1 do
    begin
      ctrl := Controls[i];
      RemoveControl(ctrl);
    end;
  end;
end;

end.

