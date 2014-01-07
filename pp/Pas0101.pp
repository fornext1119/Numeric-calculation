Program Pas0101(arg);
uses
    SysUtils, Math;
begin
    writeln(3 + 5);
    writeln(3 - 5);
    writeln(3 * 5);
    writeln(power(3, 5));
    writeln(5 / 3);
    writeln(5 div 3);
    writeln(5 mod 3);

    write(IntToStr(3 * 5) + #13#10);

	writeln(format('%3d',     [3 * 5]));
	writeln(format('%23.20f', [5 / 3]));
end.
