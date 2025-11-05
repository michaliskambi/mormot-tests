{ Simple "calculator" implementation that can add 2 numbers,
  silly code just to have something to test. }
unit Calculator;

interface

type
  TCalc = class
  public
    LastResult: Integer;
    function Add(const A, B: Integer): Integer;
    procedure CrashMe;
    procedure LeakMe;
  end;

implementation

uses SysUtils,
  mormot.core.base,
  mormot.core.log;

function TCalc.Add(const A, B: Integer): Integer;
begin
  Result := A + B;
  LastResult := Result;
  TSynLog.Add.Log(sllTrace, 'Adding % + % = %', [A, B, Result]);
end;

procedure TCalc.CrashMe;
begin
  raise Exception.Create('Crash!');
end;

procedure TCalc.LeakMe;
begin
  TObject.Create;
  TObject.Create;
  TObject.Create;
  TObject.Create;
  TObject.Create;
end;

end.
