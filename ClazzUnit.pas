unit ClazzUnit;

interface

uses
  ShareMem, UserUnit, ADODB, DB, ExceptionsUnit, SysUtils;

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
    class function from(ds: TDataSet): TClazz;
  private
//    _students
  end;

  TClazzList = array of TClazz;

  TClazzDao = class(TObject)
  public
    function FindAll: TClazzList;
    function GetById(id: Integer): TClazz;
    procedure Save(clz: TClazz);
    procedure Delete(clz: TClazz);
  private
    Query: TADOQuery;
    constructor Create(conn: TADOConnection);
  end;

var
  ClazzDao: TClazzDao;

implementation

uses
  StoreUnit, StudentUnit;

class function TClazz.from(ds: TDataSet): TClazz;
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
        Result[i] := TClazz.from(Query);
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
      Result := TClazz.from(Query);
      Close;
    end;
  end;
end;

procedure TClazzDao.Save(clz: TClazz);
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      if clz.Id = 0 then
      begin
        SQL.Text := 'insert into `clazz`(briefName, college, academy, profession, grade, clazzNumber, userId) values(:briefName, :college, :academy, :profession, :grade, :clazzNumber, :userId) ';
        with Parameters do
        begin
          ParamByName('briefName').Value := clz.BriefName;
          ParamByName('college').Value := clz.college;
          ParamByName('academy').Value := clz.academy;
          ParamByName('profession').Value := clz.profession;
          ParamByName('grade').Value := clz.grade;
          ParamByName('clazzNumber').Value := clz.clazzNumber;
          ParamByName('userId').Value := clz.userId;
        end;
      end
      else
      begin
        SQL.Text := 'update `clazz` set briefName=:briefName, college=:college, academy=:academy, profession=:profession, grade=:grade, clazzNumber=:clazzNumber where ID=:id ';
        with Parameters do
        begin
          ParamByName('briefName').Value := clz.BriefName;
          ParamByName('college').Value := clz.college;
          ParamByName('academy').Value := clz.academy;
          ParamByName('profession').Value := clz.profession;
          ParamByName('grade').Value := clz.grade;
          ParamByName('clazzNumber').Value := clz.clazzNumber;
          ParamByName('id').Value := clz.Id;
        end;
      end;
      ExecSQL;
      Close;
    end;
  end;
end;

procedure TClazzDao.Delete(clz: TClazz);
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      SQL.Text := 'delete from `clazz` where ID=:id';
      Parameters.ParamByName('id').Value := clz.Id;
      ExecSQL;
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

