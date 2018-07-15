unit StoreUnit;

interface

uses
  ADODB, Classes, ActiveX, Dialogs;

type
  LoginResult = record
    Ok: Boolean;
    Error: (UserNameNotExists, PasswordError);
  end;

  RegResult = record
    Ok: Boolean;
    Error: (UserNameHasExists, DatabaseError);
  end;

  TStore = class(TObject)
  public
    function Login(const username, password: WideString): LoginResult;
    function Reg(const username, password: WideString): RegResult;
    procedure Quit();
  private
    dbConn: TADOConnection;
    userTable: TADOTable;
    logedUserId: Integer;
//    dataSet: TADODataSet;
    addUser: TADOQuery;
    constructor Create();
  public
    destructor Destruct();
  end;

var
  Store: TStore;

implementation

constructor TStore.Create();
begin
  CoInitialize(nil); // Must be called but I don't know why.
  Self.dbConn := TADOConnection.Create(nil);
  Self.dbConn.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=ClassAddressBook.mdb';
  Self.dbConn.Open;

  Self.userTable := TADOTable.Create(nil);
  Self.userTable.Connection := Self.dbConn;
  Self.userTable.Close;
  Self.userTable.TableName := '`user`';
  Self.userTable.Open;
  Self.logedUserId := 0;

//  Self.dataSet := TADODataSet.Create(nil);
//  Self.dataSet.Connection := Self.dbConn;
//  Self.query := TADOQuery.Create(nil);
//  Self.query.Connection := Self.dbConn;
  Self.addUser := TADOQuery.Create(nil);
  self.addUser.Connection := self.dbConn;
  with Self.addUser do
  begin
    Close;
    with SQL do
    begin
      Clear;
//      Add('insert into `user`(username, password) values(:username, :password)');
      Text := 'insert into `user`(username, password) values(:username, :password)';
    end;
    Prepared := True;
    Open;
  end;

end;

function TStore.Login(const username, password: WideString): LoginResult;
var
  lr: LoginResult;
begin
  with Self do
  begin
    userTable.Filtered := False;
    userTable.Filter := 'username=''' + username + '''';
    userTable.Filtered := True;
    if userTable.RecordCount = 1 then
    begin
      userTable.First;
      if userTable.FieldByName('password').AsString = password then
      begin
        lr.Ok := True;
        logedUserId := userTable.FieldByName('ID').AsInteger;
      end
      else
      begin
        lr.Ok := False;
        lr.Error := PasswordError;
      end;
    end
    else
    begin
      lr.Ok := False;
      lr.Error := UserNameNotExists;
    end;
    userTable.Filtered := False;
  end;
  Result := lr;
end;

function TStore.Reg(const username, password: WideString): RegResult;
var
  rr: RegResult;
  insertedRowCnt: Integer;
begin
  with Self do
  begin
    userTable.Filtered := False;
    userTable.Filter := 'username=''' + username + '''';
    userTable.Filtered := True;
    if userTable.RecordCount = 0 then
    begin
      with addUser do
      begin
        Parameters.Clear;
        Parameters.ParamByName('username').Value := username;
        Parameters.ParamByName('password').Value := password;
        insertedRowCnt := ExecSQL;
        if insertedRowCnt = 1 then
        begin
          rr.Ok := true;
        end
        else
        begin
          rr.Ok := false;
          rr.Error := DatabaseError;
        end;
      end;
    end
    else
    begin
      rr.Ok := False;
      rr.Error := UserNameHasExists;
    end;
    userTable.Filtered := false;
  end;
  Result := rr;
end;

procedure TStore.Quit();
begin
  self.logedUserId := 0;
end;

destructor TStore.Destruct();
begin
  Self.dbConn.Close;
  Self.dbConn.Destroy;
  Self.userTable.Destroy;
//  Self.query.Destroy;
end;

initialization
  Store := TStore.Create;

finalization

end.

