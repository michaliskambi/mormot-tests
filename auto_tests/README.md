Test mORMOt testing capabilities.

Most of the interesting code is in `tests/` subdirectory.

We test mostly `TSynTestCase` and `TSynTestsLogged`.

The point of this code is to be super-simple and illustrate the basic principle of auto-testing: your application has a `TCalculator` class that does additions, so you write auto-tests that check it:

```delphi
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
```

See also "Test Driven Development with mORMot 2 with Delphi and FPC", from https://blog.synopse.info/?post/2025/10/29/EKON-29-Slides , but admittedly this example doesn't dive into details, making stub etc. We just show how to use `mormot.core.test` in the simplest way. Start by doing it like this, and good practices will follow from there :)