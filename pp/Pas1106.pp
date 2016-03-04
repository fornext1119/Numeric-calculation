program Pas1106(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    N = 3;

type
    TwoDimArray = array [0..N,0..N] of Double;

// １次元配列を表示
procedure disp_vector(row:array of Double);
var
    i:Integer;
begin
    for i := Low(row) to High(row) do
        write(format('%14.10f'#9, [row[i]]));
    writeln();
end;

// ２次元配列を表示
procedure disp_matrix(matrix:TwoDimArray);
var
    row, col:Integer;
begin
    for row := 0 to N do
    begin
        for col := 0 to N do
            write(format('%14.10f'#9, [matrix[row][col]]));
        writeln();
    end;
end;


// ハウスホルダー変換
procedure tridiagonalize(var a:TwoDimArray; var d:array of Double; var e:array of Double);
var
    w:array [0..N] of Double;
    v:array [0..N] of Double;
    i, j, k:Integer;
    s, t:Double;
begin
    for k := 0 to N do
        v[k] := 0.0;
        
    for k := 0 to (N - 2) do
    begin
        for i := 0 to N do
            w[i] := 0.0;
        d[k] := a[k][k];

        t :=  0.0;
        for i := (k + 1) to N do
        begin
            w[i] := a[i][k];
            t    := t + w[i] * w[i];
        end;
        s := Sqrt(t); 
        if w[k + 1] < 0 then
            s := -s;

        if Abs(s) < 0.00000000001 then
        begin
            e[k + 1] := 0.0;
        end
        else
        begin
            e[k + 1]  := -s;
            w[k + 1]  := w[k + 1] + s;
            s         := 1.0 / Sqrt(w[k + 1] * s);
            for i := (k + 1) to N do
                w[i] := w[i] * s;

            for i := (k + 1) to N do
            begin
                s := 0.0;
                for j := (k + 1) to N do
                    if j <= i then
                        s := s + a[i][j] * w[j]
                    else
                        s := s + a[j][i] * w[j];
                v[i] := s;
            end;

            s := 0.0;
            for i := (k + 1) to N do
                s := s + w[i] * v[i];
            s := s / 2.0;
            for i := (k + 1) to N do
                v[i] := v[i] - s * w[i];
            for i := (k + 1) to N do
                for j := (k + 1) to i do
                    a[i][j] := a[i][j] - (w[i] * v[j] + w[j] * v[i]);
            // 次の行は固有ベクトルを求めないなら不要
            for i := (k + 1) to N do
                a[i][k] := w[i];
        end;
    end;

    d[N - 1] := a[N - 1][N - 1];
    d[N]     := a[N][N];
    
    e[0]     := 0.0;  
    e[N]     := a[N][N - 1];
    
    // 次の行は固有ベクトルを求めないなら不要
    for k := N DownTo 0 do
    begin
        for i := 0 to N do
            w[i] := 0.0;

        if k < N - 1 then
        begin
            for i := (k + 1) to N do
                w[i] := a[i][k];
            for i := (k + 1) to N do
            begin
                s := 0.0;
                for j := (k + 1) to N do
                    s := s + a[i][j] * w[j];
                v[i] := s;
            end;
            for i := (k + 1) to N do
                for j := (k + 1) to N do
                    a[i][j] := a[i][j] - v[i] * w[j];
        end;
        for i := 0 to N do
            a[i][k] := 0.0;
        a[k][k] := 1.0;
    end;
end;

// QR分解
procedure decomp(var a:TwoDimArray; var d:array of Double; var e:array of Double);
var
    h, l:Integer;
    i, j, k:Integer;
    w, s :Double;   
    x, y, z :Double;    
    t, u :Double;   
begin
    e[0] := 1.0;
    h    := N;
    while (Abs(e[h]) < 0.00000000001) do
        dec(h);

    while (h > 0) do
    begin
        e[0] := 0.0;
        l := h - 1;
        while (Abs(e[l]) >= 0.00000000001) do
            dec(l);

        for j := 1 to 100 do
        begin
            w := (d[h - 1] - d[h]) / 2.0;
            s := Sqrt(w * w + e[h] * e[h]);
            if w < 0.0 then 
                s := -s;

            x := d[l] - d[h] + e[h] * e[h] / (w + s);
            y := e[l + 1];
            z := 0.0;
            t := 0.0;
            u := 0.0;
            for k := l to (h - 1) do
            begin
                if Abs(x) >= Abs(y) then
                begin
                    t := -y / x;  
                    u := 1.0 / Sqrt(t * t + 1.0);  
                    s := t * u;
                end
                else
                begin
                    t := -x / y;
                    s := 1.0 / Sqrt(t * t + 1.0);  
                    if t < 0 then 
                        s := -s;
                    u := t * s;
                end;
                w := d[k] - d[k + 1];
                t := (w * s + 2.0 * u * e[k + 1]) * s;
                d[k    ] := d[k    ] - t;  
                d[k + 1] := d[k + 1] + t;
                e[k    ] := u * e[k] - s * z;
                e[k + 1] := e[k + 1] * (u * u - s * s) + w * s * u;

                // 次の行は固有ベクトルを求めないなら不要
                for i := 0 to N do
                begin
                    x := a[k    , i];  
                    y := a[k + 1, i];
                    a[k    , i] := u * x - s * y;  
                    a[k + 1, i] := s * x + u * y;
                end;

                if k < N - 1 then
                begin
                    x        :=      e[k + 1];  
                    y        := -s * e[k + 2];  
                    z        := y;
                    e[k + 2] := u * e[k + 2];
                end;
            end;

            write(format('%3d'#9, [j]));
            disp_vector(d);

            // 収束判定
            if (Abs(e[h]) < 0.00000000001) then break;
        end;

        e[0] := 1.0;  
        while (Abs(e[h]) < 0.00000000001) do
            dec(h);
    end;

    // 次の行は固有ベクトルを求めないなら不要
    for k := 0 to (N - 1) do
    begin
        l := k;
        for i := (k + 1) to N  do
            if d[i] > d[l] then 
                l := i;

        t    := d[k];  
        d[k] := d[l];  
        d[l] := t;

        for i := 0 to N do
        begin
            t       := a[k][i];  
            a[k][i] := a[l][i];  
            a[l][i] := t;
        end;
    end;
end;

// ハウスホルダー変換とQR分解で固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));

    d:array [0..N] of Double;
    e:array [0..N] of Double;
begin
    // ハウスホルダー変換
    tridiagonalize(a, d, e);

    // QR分解
    decomp(a, d, e);

    writeln();
    writeln('eigenvalue');
    disp_vector(d);

    writeln();
    writeln('eigenvector');
    disp_matrix(a);
end.
