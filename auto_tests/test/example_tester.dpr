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
  mormot.core.os,
  mormot.core.log,
  mormot.core.test,
  // add below all your test units
  test.calculator;

{ TAllTests }

type
  TAllTests = class(TSynTestsLogged)
  public
    class procedure RunAsConsole(const CustomIdent: string = '';
      withLogs: TSynLogLevels = [sllLastError, sllError, sllException, sllExceptionOS, sllFail];
      options: TSynTestOptions = []; const workdir: TFileName = ''); override;
  published
    // All published methods will run
    procedure CoreUnits;
  end;

class procedure TAllTests.RunAsConsole(const CustomIdent: string;
  withLogs: TSynLogLevels; options: TSynTestOptions; const workdir: TFileName);
begin
  { Make the TSynTests.RunAsConsole behavior more comfortable than in mORMot
    default: accept --noenter on all systems, not only on Windows.
    Makes it easier to write cross-platform scripts. }
  {$ifdef OSPOSIX}
  Executable.Command.Option('noenter', 'do not wait for ENTER key on exit (ignored on POSIX systems)');
  {$endif OSPOSIX}
  inherited;
end;

procedure TAllTests.CoreUnits;
begin
  AddCase([
    TTestCalculator
  ]);
end;

begin
  TAllTests.RunAsConsole('Calculator Tests',
    LOG_FILTER[lfExceptions] // + [sllErrors, sllWarning]
  );

  // Additional info about memory status
  // {$ifdef FPC_X64MM}
  // WriteHeapStatus(' ', 16, 8, {compileflags=}true);
  // {$endif FPC_X64MM}
end.

