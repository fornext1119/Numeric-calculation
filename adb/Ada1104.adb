with TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1104 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((5.0, 4.0, 1.0, 1.0)
                                ,(4.0, 5.0, 1.0, 1.0)
                                ,(1.0, 1.0, 4.0, 2.0)
                                ,(1.0, 1.0, 2.0, 4.0));

    q:Long_Float_TwoDimArray;
    r:Long_Float_TwoDimArray;

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

    -- QR•ª‰ð
    procedure decomp(a:Long_Float_TwoDimArray; q:in out Long_Float_TwoDimArray; r:in out Long_Float_TwoDimArray) is
        t, s:Long_Float;
	    x:Long_Float_Array;
    begin

        for k in 0..N loop
            for i in 0..N loop
	            x(i) := a(i, k);
	        end loop;
            for j in 0..(k - 1) loop
	            t := 0.0;
                for i in 0..N loop
	                t := t + a(i, k) * q(i, j);
	            end loop;
	            r(j, k) := t;
	            r(k, j) := 0.0;
                for i in 0..N loop
	                x(i) := x(i) - t * q(i, j);
	            end loop;
	        end loop;

	        s := 0.0;
            for i in 0..N loop
	            s := s + x(i) * x(i);
	        end loop;
	        r(k, k) := Sqrt(s);
            for i in 0..N loop
	            q(i, k) := x(i) / r(k, k);
	        end loop;
	    end loop;
	end decomp;

-- QR•ª‰ð‚ÅŒÅ—L’l‚ð‹‚ß‚é
    e:Long_Float := 0.0;
begin
	for k in 1..200 loop
    	-- QR•ª‰ð
	    decomp(a, q, r);
        -- s—ñ‚ÌÏ
        multiply(r, q, a);
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
end Ada1104;
