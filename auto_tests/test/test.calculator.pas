{ TTestCalculator with a number of auto-tests for Calculator unit. }
unit test.calculator;

{ Enable additional tests that are known to cause memory leaks. }
{.$define TEST_MEM_LEAKS}

{ Enable additional tests that are known to cause crashes (exception,
  including access violation and potentially undefined behavior). }
{.$define TEST_CRASHES}

interface

{$I mormot.defines.inc}

uses
  SysUtils,
  mormot.core.base,
  mormot.core.log,
  mormot.core.test;

type
  // Tests for Calculator.
  TTestCalculator = class(TSynTestCase)
  published
    // All published methods will run.

    // Test TCalculator creation/destruction
    procedure Basic;
    // Test TCalculator.Add.
    procedure Add;

    {$ifdef TEST_MEM_LEAKS}
    // Test memory leaks.
    procedure MemLeaks1;
    procedure MemLeaks2;
    {$endif TEST_MEM_LEAKS}

    {$ifdef TEST_CRASHES}
    // Test crashes.
    procedure Crash1;
    procedure Crash2;
    {$endif TEST_CRASHES}
  end;

implementation

uses Calculator;

procedure TTestCalculator.Basic;
var
  C: TCalc;
begin
  C := TCalc.Create;
  Check(C <> nil);
  FreeAndNil(C);
  Check(C = nil);
end;

procedure TTestCalculator.Add;
var
  C: TCalc;
begin
  C := TCalc.Create;
  try
    CheckEqual(C.Add(1, 2), 3);
    CheckNotEqual(C.Add(1, 2), 4);
  finally
    FreeAndNil(C);
  end;
end;

{$ifdef TEST_MEM_LEAKS}
procedure TTestCalculator.MemLeaks1;
var
  C: TCalc;
begin
  // This is mem-leak because of invalid test.
  C := TCalc.Create;
end;

procedure TTestCalculator.MemLeaks2;
var
  C: TCalc;
begin
  // This is mem-leak because of invalid TCalc
  C := TCalc.Create;
  try
    C.LeakMe;
  finally
    FreeAndNil(C);
  end;
end;
{$endif TEST_MEM_LEAKS}

{$ifdef TEST_CRASHES}
procedure TTestCalculator.Crash1;
var
  C: TCalc;
begin
  C := TCalc(PtrInt(1234567890));
  C.Add(1, 2); // should crash as C is invalid pointer, setting LastResult should crash
end;

procedure TTestCalculator.Crash2;
var
  C: TCalc;
begin
  C := TCalc.Create;
  try
    C.CrashMe;
  finally
    FreeAndNil(C);
  end;
end;
{$endif TEST_CRASHES}

end.
