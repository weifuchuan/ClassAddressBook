unit ClazzUnit;

interface

uses
  UserUnit, ADODB, DB, ExceptionsUnit, SysUtils;

type
  TClazz = class(TObject)
  public
    Id: Integer;
    BriefName: WideString;
    College: WideString;
    Academy: WideString;
    Profession: WideString;
    Grade: WideString;
    ClazzNumber: WideString;
    UserId: Integer;
  private
//    _students
  end;

  TClazzList = array of TClazz;

  TClazzDao = class(TObject)
  public
    function FindAll: TClazzList;
    function GetById(id: Integer): TClazz;
  private
    Query: TADOQuery;
    constructor Create(conn: TADOConnection);
  end;

var
  ClazzDao: TClazzDao;

implementation

uses
  StoreUnit, StudentUnit;

function from(ds: TDataSet): TClazz;
begin
  Result := TClazz.Create;
  with ds do
  begin
    Result.Id := FieldByName('ID').AsInteger;
    Result.BriefName := FieldByName('briefName').AsString;
    Result.College := FieldByName('college').AsString;
    Result.Academy := FieldByName('academy').AsString;
    Result.Profession := FieldByName('profession').AsString;
    Result.Grade := FieldByName('grade').AsString;
    Result.ClazzNumber := FieldByName('clazzNumber').AsString;
    Result.UserId := FieldByName('userId').AsInteger;
  end;
end;

////////////////////////////
// TClazz
////////////////////////////



////////////////////////////
// TClazzDao
////////////////////////////

constructor TClazzDao.Create(conn: TADOConnection);
begin
  Self.Query := TADOQuery.Create(nil);
  Self.Query.Connection := Store.Conn;
end;

function TClazzDao.FindAll: TClazzList;
var
  i: Integer;
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      sql.Text := 'select * from `clazz` where userId=:userId';
      Parameters.ParamByName('userId').Value := Store.MyId;
      Open;
      setlength(Result, recordCount);
      First;
      for i := 0 to RecordCount - 1 do
      begin
        Result[i] := from(Query);
        Next;
      end;
      Close;
    end;
  end;
end;

function TClazzDao.GetById(id: Integer): TClazz;
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      SQL.Text := 'select * from `clazz` where ID=:id';
      Parameters.ParamByName('id').Value := id;
      Open;
      if not Query.RecordCount = 1 then
        raise DataNotFoundException.Create('Clazz not found by id = ' + inttostr(id));
      First;
      Result := from(Query);
      Close;
    end;
  end;
end;

initialization
begin
  ClazzDao := TClazzDao.Create(Store.Conn);
end;

finalization

end.

