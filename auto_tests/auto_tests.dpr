{
  Simplest test utilizing Calculator.
}

{$I mormot.defines.inc}

uses
  {$I mormot.uses.inc}
  SysUtils,
  mormot.core.log,
  mormot.core.base,
  Calculator;

var
  Calc: TCalc;
  LogFamily: TSynLogFamily;
begin
  LogFamily := TSynLog.Family;
  LogFamily.Level := LOG_VERBOSE;
  LogFamily.PerThreadLog := ptIdentifiedInOnFile;
  LogFamily.EchoToConsole := LOG_VERBOSE;

  Calc := TCalc.Create;
  try
    Writeln('Meaning of life? ', Calc.Add(40, 2));
  finally
    FreeAndNil(Calc);
  end;
end.
