unit UserUnit;

interface

uses
  ShareMem, ADODB, DB, ExceptionsUnit, SysUtils;

type
  TUser = class(TObject)
  public
    Id: Integer;
    Name: WideString;
    Password: string;
    isManager: Boolean;
  private
  end;

  TUserList = array of TUser;

  TUserDao = class(TObject)
  public
    function FindAll: TUserList;
    function GetById(id: Integer): TUser;
  private
    Query: TADOQuery;
    constructor Create(conn: TADOConnection);
  end;

var
  UserDao: TUserDao;

implementation

uses
  StoreUnit;

function from(ds: TDataSet): TUser;
var
  user: TUser;
begin
  user := TUser.Create;
  with ds do
  begin
    user.Id := FieldByName('ID').AsInteger;
    user.Name := FieldByName('username').AsString;
    user.Password := FieldByName('password').AsString;
    user.isManager := FieldByName('isManager').AsBoolean;
  end;
  Result := user;
end;

///////////////////////////
// UserDao
///////////////////////////
constructor TUserDao.Create(conn: TADOConnection);
begin
  Self.Query := TADOQuery.Create(nil);
  Self.Query.Connection := Store.Conn;
end;

function TUserDao.FindAll: TUserList;
var
  list: TUserList;
  i: Integer;
begin
  with Self do
  begin
    Query.Close;
    Query.SQL.Text := 'select * from `user`';
    Query.Open;
    with Query do
    begin
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

function TUserDao.GetById(id: Integer): TUser;
begin
  with Self do
  begin
    with Query do
    begin
      Close;
      with SQL do
      begin
        Text := 'select * from `user` where ID=:id';
        Parameters.ParamByName('id').Value := id;
      end;
      Open;
      if not Query.RecordCount = 1 then
        raise DataNotFoundException.Create('User not found by id = ' + inttostr(id));
      First;
      First;
      Result := from(Query);
      Close;
    end;
  end;
end;

initialization
begin
  UserDao := TUserDao.Create(Store.Conn);
end;

finalization
begin
  UserDao.Query.Destroy;
end;

end.

