unit EventEmitterUnit;

interface

uses
  IniFiles;

type
  

  TListenner = procedure of object;

  TListennerList = array of TListenner;

  TPListennerList = ^TListennerList;

  TEventEmitter = class
  public
    constructor Create();
//    procedure addEventListenner(event:string; );
  private
    map: THashedStringList;
  end;

implementation

constructor TEventEmitter.Create();
begin
  self.map := THashedStringList.Create;
end;

end.

