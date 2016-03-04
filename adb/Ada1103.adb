with TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1103 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((5.0, 4.0, 1.0, 1.0)
                                ,(4.0, 5.0, 1.0, 1.0)
                                ,(1.0, 1.0, 4.0, 2.0)
                                ,(1.0, 1.0, 2.0, 4.0));

    l:Long_Float_TwoDimArray;
    u:Long_Float_TwoDimArray;

    -- ‘ÎŠp—v‘f‚ð•\Ž¦
    procedure disp_eigenvalue(a:Long_Float_TwoDimArray) is
    begin
        for i in 0..N loop
            Put(a(i, i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
	    end loop;
        Put_Line("");
	end disp_eigenvalue;

    -- s—ñ‚ÌÏ
    procedure multiply(a:Long_Float_TwoDimArray; b:Long_Float_TwoDimArray; c:in out Long_Float_TwoDimArray) is
        s:Long_Float;
    begin
        for i in 0..N loop
            for j in 0..N loop
	            s := 0.0;
                for k in 0..N loop
	                s := s + a(i, k) * b(k, j);
	            end loop;
	            c(i, j) := s;
	        end loop;
	    end loop;
	end multiply;

    -- LU•ª‰ð
    procedure decomp(a:Long_Float_TwoDimArray; l:in out Long_Float_TwoDimArray; u:in out Long_Float_TwoDimArray) is
        t:Long_Float;
    begin
        for i in 0..N loop
            for j in 0..N loop
	            l(i, j) := 0.0;
	            u(i, j) := 0.0;
	        end loop;
	    end loop;

	    l(0, 0) := 1.0;
	    for j in 0..N loop
	        u(0, j) := a(0, j);
	    end loop;

	    for i in 1..N loop
	        u(i, 0) := 0.0;
	        l(0, i) := 0.0;
	        l(i, 0) := a(i, 0) / u(0, 0);
	    end loop;
	    for i in 1..N loop
	        l(i, i) := 1.0;
	        t       := a(i, i);
            for k in 0..i loop
	            t := t - l(i, k) * u(k, i);
	        end loop;
	        u(i, i) := t;
            for j in (i + 1)..N loop
	            u(j, i) := 0.0;
                l(i, j) := 0.0;
	            t       := a(j, i);
	            for k in 0..i loop
	                t := t - l(j, k) * u(k, i);
	            end loop;
	            l(j, i) := t / u(i, i);
	            t       := a(i, j);
	            for k in 0..i loop
	                t := t - l(i, k) * u(k, j);
	            end loop;
	            u(i, j) := t;
	        end loop;
	    end loop;
	end decomp;

-- LR•ª‰ð‚ÅŒÅ—L’l‚ð‹‚ß‚é
    e:Long_Float := 0.0;
begin
	for k in 1..200 loop
	    -- LU•ª‰ð
	    decomp(a, l, u);
        -- s—ñ‚ÌÏ
        multiply(u, l, a);
        -- ‘ÎŠp—v‘f‚ð•\Ž¦
        Put(k, Width=> 3);
        Put(Ascii.HT);
        disp_eigenvalue(a);

        -- Žû‘©”»’è
        e := 0.0;
        for i in 1..N loop
            for j in 0..(i - 1) loop
                e := e + Abs(a(i, j));
            end loop;
        end loop;
        if e < 0.00000000001 then
            exit;
        end if;
    end loop;

    Put_Line("");
    Put_Line("eigenvalue");    
    disp_eigenvalue(a);
end Ada1103;
