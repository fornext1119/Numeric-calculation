import std.stdio;
import std.math;

const int N = 4;

// ハウスホルダー変換とQR分解で固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
    double d[N]; 
    double e[N]; 

    // ハウスホルダー変換
    tridiagonalize(a, d, e);

	// QR分解
	decomp(a, d, e);

    writefln("\neigenvalue");
	disp_vector(d);

    writefln("\neigenvector");
	disp_matrix(a);
}

// ハウスホルダー変換
void tridiagonalize(ref double[N][N] a, ref double[N] d, ref double[N] e) 
{
   	double v[N]; 

    foreach (k; 0..N - 2) 
    {
	    double w[N] = [0.0 ,0.0 ,0.0 ,0.0];
        d[k] = a[k][k];

        double t = 0.0;
        foreach (i; k + 1..N) 
        {
            w[i] =  a[i][k];
            t    += w[i] * w[i];
        }
        double s = sqrt(t);
        if (w[k + 1] < 0)
            s = -s;

        if (fabs(s) < 0.00000000001)
            e[k + 1] = 0.0;
        else 
        {
            e[k + 1]  = -s;
            w[k + 1] +=  s;
            s = 1 / sqrt(w[k + 1] * s);
        	foreach (i; k + 1..N)
                w[i] *= s;

        	foreach (i; k + 1..N) 
        	{
                s = 0.0;
	        	foreach (j; k + 1..N) 
	        	{
                    if (j <= i)
                        s += a[i][j] * w[j];
                    else
                        s += a[j][i] * w[j];
                }
                v[i] = s;
            }

            s = 0.0;
        	foreach (i; k + 1..N)
                s += w[i] * v[i];
            s /= 2.0;
        	foreach (i; k + 1..N)
                v[i] -= s * w[i];
        	foreach (i; k + 1..N)
	        	foreach (j; k + 1..i + 1)
                    a[i][j] -= w[i] * v[j] + w[j] * v[i];
            // 次の行は固有ベクトルを求めないなら不要
        	foreach (i; k + 1..N)
                a[i][k] = w[i];
        } 
    }

    d[N - 2] = a[N - 2][N - 2];
    d[N - 1] = a[N - 1][N - 1];
    
    e[0]     = 0.0;  
    e[N - 1] = a[N - 1][N - 2];

    // 次の行は固有ベクトルを求めないなら不要
	foreach_reverse (k; 0..N) 
	{
	    double w[N] = [0.0 ,0.0 ,0.0 ,0.0];
        if (k < N - 2) 
        {
			foreach (i; k + 1..N)
                w[i] = a[i][k];
			foreach (i; k + 1..N) 
			{
                double s = 0.0;
    			foreach (j; k + 1..N)
                    s += a[i][j] * w[j];
                v[i] = s;
            }
			foreach (i; k + 1..N)
    			foreach (j; k + 1..N)
                    a[i][j] -= v[i] * w[j];
        }
		foreach (i; 0..N)
            a[i][k] = 0.0;
        a[k][k] = 1.0;
    }
}

// QR分解
void decomp(ref double[N][N] a, ref double[N] d, ref double[N] e) 
{
    e[0] = 1.0;
    int h = N - 1;
    while (fabs(e[h]) < 0.00000000001) h--;

    while (h > 0) 
    {
        e[0] = 0.0;
        int l = h - 1;
        while (fabs(e[l]) >= 0.00000000001) l--;

        foreach (j; 1..100) 
        {
            double w = (d[h - 1] - d[h]) / 2.0;
            double s = sqrt(w * w + e[h] * e[h]);
            if (w < 0.0)
                s = -s;

            double x = d[l] - d[h] + e[h] * e[h] / (w + s);
            double y = e[l + 1];
            double z = 0.0;
            double t = 0.0;
            double u = 0.0;
            foreach (k; l..h) 
            {
                if (fabs(x) >= fabs(y)) 
                {
                    t = -y / x;
                    u = 1 / sqrt(t * t + 1.0);
                    s = t * u;
                }
                else 
                {
                    t = -x / y;
                    s = 1 / sqrt(t * t + 1.0);
                    if (t < 0)
                        s = -s;
                    u = t * s;
                }
                w = d[k] - d[k + 1];
                t = (w * s + 2 * u * e[k + 1]) * s;
                d[k    ] = d[k    ] - t;
                d[k + 1] = d[k + 1] + t;
                e[k    ] = u * e[k] - s * z;
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u;

                // 次の行は固有ベクトルを求めないなら不要
                foreach (i; 0..N) 
                {
                    x = a[k    ][i];  
                    y = a[k + 1][i];
                    a[k    ][i] = u * x - s * y;
                    a[k + 1][i] = s * x + u * y;
                }

                if (k < N - 2) 
                {
                    x = e[k + 1];  
                    y = -s * e[k + 2];  
                    z = y;
                    e[k + 2] = u * e[k + 2];
                }
            }

			writef("%3d\t", j);
			disp_vector(d);

	        // 収束判定
			if (fabs(e[h]) < 0.00000000001) break;
        }

        e[0] = 1.0;  
        while (fabs(e[h]) < 0.00000000001) h--;
    }

    // 次の行は固有ベクトルを求めないなら不要
    foreach (k; 0..N - 1) 
    {
        int l = k;
        foreach (i; k + 1..N) 
            if (d[i] > d[l])
                l = i;

        double t = d[k];  
        d[k] = d[l];  
        d[l] = t;

		foreach (i; 0..N) 
		{
	        t       = a[k][i];  
	        a[k][i] = a[l][i];  
	        a[l][i] = t;
        }
    }
}

// １次元配列を表示
void disp_vector(double[N] row) 
{
    foreach (i; 0..N)
		writef("%14.10f\t", row[i]);
    writefln("");
}
// ２次元配列を表示
void disp_matrix(double[N][N] matrix) 
{
    foreach (row; 0..N) 
    {
    	foreach (col; 0..N)
			writef("%14.10f\t", matrix[row][col]);
	    writefln("");
    }
}
