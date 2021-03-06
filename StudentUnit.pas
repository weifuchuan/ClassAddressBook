unit StudentUnit;

interface

uses
  ShareMem, UserUnit, ClazzUnit, ADODB, DB;

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
    class function from(ds: TDataSet): TStudent;
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
    procedure Save(student: TStudent);
    procedure Delete(student: TStudent);
  private
    Query: TADOQuery;
    constructor Create(conn: TADOConnection);
  end;

var
  StudentDao: TStudentDao;

implementation

uses
  StoreUnit;

class function TStudent.from(ds: TDataSet): TStudent;
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
      SQL.Text := 'select * from `student` where userId=:userId';
      Parameters.ParamByName('userId').Value := Store.MyId;
      Open;
      First;
      SetLength(list, RecordCount);
      for i := 0 to RecordCount - 1 do
      begin
        list[i] := TStudent.from(Query);
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
      SQL.Text := 'select * from `student` where clazzId=:id and userId=:userId';
      Parameters.ParamByName('id').Value := id;
      Parameters.ParamByName('userId').Value := Store.MyId;
      Open;
      SetLength(Result, RecordCount);
      First;
      for i := 0 to RecordCount - 1 do
      begin
        Result[i] := TStudent.from(Query);
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TStudentDao.Save(student: TStudent);
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      if student.Id = 0 then // add
      begin
        SQL.Text := 'insert into `student`(studentName, phone, address, clazzId, userId) values(:name, :phone, :address, :clazzId, :userId)';
        Parameters.ParamByName('name').Value := student.Name;
        Parameters.ParamByName('phone').Value := student.Phone;
        Parameters.ParamByName('address').Value := student.Address;
        Parameters.ParamByName('clazzId').Value := student.clazzId;
        Parameters.ParamByName('userId').Value := student.userId;
        ExecSQL;
      end
      else  // modify
      begin
        SQL.Text := 'update `student` set studentName=:name, phone=:phone, address=:address, clazzId=:clazzId where ID=:id';
        Parameters.ParamByName('id').Value := student.Id;
        Parameters.ParamByName('name').Value := student.Name;
        Parameters.ParamByName('phone').Value := student.Phone;
        Parameters.ParamByName('address').Value := student.Address;
        Parameters.ParamByName('clazzId').Value := student.clazzId;
        ExecSQL;
      end;
      Close;
    end;
  end;
end;

procedure TStudentDao.Delete(student: TStudent);
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      SQL.Text := 'delete from `student` where ID=:id';
      Parameters.ParamByName('id').Value := student.Id;
      ExecSQL;
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

