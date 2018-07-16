unit StudentUnit;

interface

uses
  UserUnit, ClazzUnit, ADODB, DB;

type
  TStudent = class(TObject)
  public
    Id: Integer;
    Name: WideString;
    Phone: string;
    Birthday: string;
    Sex: WideString;
    Address: WideString;
    UserId: Integer;
    ClazzId: Integer;
  private
    _user: TUser;
    _clazz: TClazz;
    function GetUser: TUser;
    function GetClazz: TClazz;
  public
    property User: TUser read GetUser;
    property Clazz: TClazz read GetClazz;
  end;

  TStudentList = array of TStudent;

  TStudentDao = class
  public
    function FindAll: TStudentList;
    function FindByCLazzId(id: Integer): TStudentList;
  private
    Query: TADOQuery;
    constructor Create(conn: TADOConnection);
  end;

var
  StudentDao: TStudentDao;

implementation

uses
  StoreUnit;

function from(ds: TDataSet): TStudent;
begin
  Result := TStudent.Create;
  with ds do
  begin
    Result.Id := FieldByName('ID').AsInteger;
    Result.Name := FieldByName('studentName').AsString;
    Result.Phone := FieldByName('phone').AsString;
    Result.Birthday := FieldByName('birthday').AsString;
    Result.Sex := FieldByName('sex').AsString;
    Result.Address := FieldByName('address').AsString;
    Result.ClazzId := FieldByName('clazzId').AsInteger;
    Result.UserId := FieldByName('userId').AsInteger;
  end;
end;

/////////////////////////////
// TStudent
/////////////////////////////

function TStudent.GetUser: TUser;
begin
  if self._user = nil then
  begin
    Self._user := UserDao.GetById(self.UserId);
  end;
  Result := Self._user;
end;

function TStudent.GetClazz: TClazz;
begin
  if self._clazz = nil then
  begin
    Self._clazz := ClazzDao.GetById(self.ClazzId);
  end;
  Result := Self._clazz;
end;

/////////////////////////////
// TStudentDao
/////////////////////////////

function TStudentDao.FindAll: TStudentList;
var
  i: Integer;
  list: TStudentList;
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      SQL.Text := 'select * from `student`';
      Open;
      First;
      SetLength(list, RecordCount);
      for i := 0 to RecordCount - 1 do
      begin
        list[i] := from(Query);
        Next;
      end;
      Close;
    end;
  end;
  Result := list;
end;

function TStudentDao.FindByCLazzId(id: integer): TStudentList;
var
  i: Integer;
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      SQL.Text := 'select * from `student` where clazzId=:id';
      Parameters.ParamByName('id').Value := id;
      Open;
      SetLength(Result, RecordCount);
      for i := 0 to RecordCount do
      begin
        Result[i] := from(Query);
      end;
      Close;
    end;
  end;
end;

constructor TStudentDao.Create(conn: TADOConnection);
begin
  Self.Query := TADOQuery.Create(nil);
  Self.Query.Connection := Store.Conn;
end;

initialization
begin
  StudentDao := TStudentDao.Create(Store.Conn);
end;

end.

