program example_tester;

{$I mormot.defines.inc}

{$ifdef OSWINDOWS}
  {$apptype console}
{$endif OSWINDOWS}

uses
  {$I mormot.uses.inc}
  // mormot2tests has it, do we need it? mormot.uses.inc doesn't take care of it.
  // {$ifdef UNIX}
  // cwstring, // needed as fallback if ICU is not available
  // {$endif UNIX}
  classes,
  sysutils,
  mormot.core.base,
  mormot.core.log,
  mormot.core.test,
  // add below all your test units
  test.calculator;

{ TIntegrationTests }

type
  TIntegrationTests = class(TSynTestsLogged)
  published
    // All published methods will run
    procedure CoreUnits;
  end;

procedure TIntegrationTests.CoreUnits;
begin
  AddCase([
    TTestCalculator
  ]);
end;

begin
  TIntegrationTests.RunAsConsole('Calculator Tests',
    LOG_FILTER[lfExceptions] // + [sllErrors, sllWarning]
  );
end.

