unit ClazzFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StudentFrameUnit, ClazzUnit, ExtCtrls, StdCtrls;

type
  TframeClazz = class(TFrame)
    grp: TGroupBox;
    scrlbxStudents: TScrollBox;
    panelStudents: TPanel;
  private
    clazz: TClazz;
  public
    procedure Init(clazz: TClazz);
  end;

implementation

{$R *.dfm}

procedure TframeClazz.Init(clazz:TClazz);
begin
  self.clazz:=clazz;
  
end;

end.

