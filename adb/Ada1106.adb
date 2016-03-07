with TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1106 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((5.0, 4.0, 1.0, 1.0)
                                ,(4.0, 5.0, 1.0, 1.0)
                                ,(1.0, 1.0, 4.0, 2.0)
                                ,(1.0, 1.0, 2.0, 4.0));

    d, e:Long_Float_Array;
        
    -- １次元配列を表示
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

	-- ２次元配列を表示
    procedure disp_matrix(matrix:Long_Float_TwoDimArray) is
    begin
	    for row in 0..N loop
		    for col in 0..N loop
                Put(matrix(row, col), Fore=>3, Aft=>10, Exp=>0);
                Put(Ascii.HT);
		    end loop;
	        New_Line;
	    end loop;
	end disp_matrix;

	-- ハウスホルダー変換
	procedure tridiagonalize(a:in out Long_Float_TwoDimArray; d:in out Long_Float_Array; e:in out Long_Float_Array) is
        w, v:Long_Float_Array;        
        t, s:Long_Float;
    begin
        for k in 0..N loop
            v(k) := 0.0;
        end loop;
	    for k in 0..(N - 2) loop
            for i in 0..N loop
                w(i) := 0.0;
            end loop;
	        d(k) := a(k, k);

	        t := 0.0;
	        for i in (k + 1)..N loop
	            w(i) := a(i, k);
	            t    := t + w(i) * w(i);
	        end loop;
	        s := Sqrt(t); 
	        if w(k + 1) < 0.0 then
	            s := -s;
	        end if;

	        if Abs(s) < 0.00000000001 then
	            e(k + 1) := 0.0;
	        else
	            e(k + 1) := -s;
	            w(k + 1) := w(k + 1) + s;
	            s := 1.0 / Sqrt(w(k + 1) * s);
	            for i in (k + 1)..N loop
	                w(i) := w(i) * s;
	            end loop;

	            for i in (k + 1)..N loop
	                s := 0.0;
	                for j in (k + 1)..N loop
	                    if j <= i then
	                        s := s + a(i, j) * w(j);
	                    else
	                        s := s + a(j, i) * w(j);
	                    end if;
	                end loop;
	                v(i) := s;
	            end loop;

	            s := 0.0;
	            for i in (k + 1)..N loop
	                s := s + w(i) * v(i);
	            end loop;
	            s := s / 2.0;
	            for i in (k + 1)..N loop
	                v(i) := v(i) - s * w(i);
	            end loop;
	            for i in (k + 1)..N loop
	                for j in (k + 1)..i loop
	                    a(i, j) := a(i, j) - (w(i) * v(j) + w(j) * v(i));
	                end loop;
	            end loop;
                
	            -- 次の行は固有ベクトルを求めないなら不要
	            for i in (k + 1)..N loop
	                a(i, k) := w(i);
	            end loop;
	        end if; 
	    end loop;

	    d(N - 1) := a(N - 1, N - 1);
	    d(N)     := a(N, N);
	    
	    e(0)     := 0.0;  
	    e(N)     := a(N, N - 1);
	    
	    -- 次の行は固有ベクトルを求めないなら不要
	    for k in reverse 0..N loop
            for i in 0..N loop
                w(i) := 0.0;
            end loop;
	        if k < N - 1 then
	            for i in (k + 1)..N loop
	                w(i) := a(i, k);
	            end loop;
	            for i in (k + 1)..N loop
	                s := 0.0;
	                for j in (k + 1)..N loop
	                    s := s + a(i, j) * w(j);
	                end loop;
	                v(i) := s;
	            end loop;
	            for i in (k + 1)..N loop
	                for j in (k + 1)..N loop
	                    a(i, j) := a(i, j) - v(i) * w(j);
	                end loop;
	            end loop;
	        end if;
	        for i in 0..N loop
	            a(i, k) := 0.0;
	        end loop;
	        a(k, k) := 1.0;
	    end loop;
	end tridiagonalize;

	-- QR分解
	procedure decomp(a:in out Long_Float_TwoDimArray; d:in out Long_Float_Array; e:in out Long_Float_Array) is
        h, l:Integer;
        s, t, u, w, x, y, z:Long_Float;
    begin
	    e(0) := 1.0;
	    h := N;
	    while (Abs(e(h)) < 0.00000000001) loop
	        h := h -1;
	    end loop;

	    while (h > 0) loop
	        e(0) := 0.0;
	        l := h - 1;
	        while (Abs(e(l)) >= 0.00000000001) loop
	            l := l - 1;
	        end loop;
	        for j in 1..100 loop
	            w := (d(h - 1) - d(h)) / 2.0;
	            s := Sqrt(w * w + e(h) * e(h));
	            if w < 0.0 then 
	                s := -s;
	            end if;

	            x := d(l) - d(h) + e(h) * e(h) / (w + s);
	            y := e(l + 1);
	            z := 0.0;
	            t := 0.0;
	            u := 0.0;
	            for k in l..(h - 1) loop
	                if Abs(x) >= Abs(y) then
	                    t := -y / x;  
	                    u := 1.0 / Sqrt(t * t + 1.0);  
	                    s := t * u;
	                else
	                    t := -x / y;
	                    s := 1.0 / Sqrt(t * t + 1.0);  
	                    if t < 0.0 then 
	                        s := -s;
	                    end if;
	                    u := t * s;
	                end if;
	                w := d(k) - d(k + 1);
	                t := (w * s + 2.0 * u * e(k + 1)) * s;
	                d(k    ) := d(k    ) - t;  
	                d(k + 1) := d(k + 1) + t;
	                e(k    ) := u * e(k) - s * z;
	                e(k + 1) := e(k + 1) * (u * u - s * s) + w * s * u;

	                -- 次の行は固有ベクトルを求めないなら不要
	                for i in 0..N loop
	                    x := a(k    , i);  
	                    y := a(k + 1, i);
	                    a(k    , i) := u * x - s * y;  
	                    a(k + 1, i) := s * x + u * y;
	                end loop;

	                if k < N - 1 then
	                    x := e(k + 1);  
	                    y := -s * e(k + 2);  
	                    z := y;
	                    e(k + 2) := u * e(k + 2);
	                end if;
	            end loop;

                Put(j, Width=> 3);
                Put(Ascii.HT);
				disp_vector(d);

		        -- 収束判定
				if (Abs(e(h)) < 0.00000000001) then
                    exit;
                end if;
	        end loop;

	        e(0) := 1.0;  
	        while (Abs(e(h)) < 0.00000000001) loop
	            h := h - 1;
	        end loop;
	    end loop;

	    -- 次の行は固有ベクトルを求めないなら不要
	    for k in 0..(N - 1) loop
	        l := k;
	        for i in (k + 1)..N loop 
	            if d(i) > d(l) then 
	                l := i;
	            end if;
	        end loop;

	        t    := d(k);  
	        d(k) := d(l);  
	        d(l) := t;

			for i in 0..N loop
		        t       := a(k, i);  
		        a(k, i) := a(l, i);  
		        a(l, i) := t;
	        end loop;
	    end loop;
	end decomp;

-- ハウスホルダー変換とQR分解で固有値を求める
begin
	-- ハウスホルダー変換;
	tridiagonalize(a, d, e);

	-- QR分解
	decomp(a, d, e);
    New_Line;

    Put_Line("eigenvalue");
    disp_vector(d);
    New_Line;

    Put_Line("eigenvector");
	disp_matrix(a);
end Ada1106;