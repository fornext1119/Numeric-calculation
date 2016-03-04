# coding: Shift_JIS

# 初項:a, 公差:a で 上限:lim の数列の総和を返す関数
def sn(a, lim):
    n = int(lim) / a        # 項数:n  =  上限:lim / 公差:a
    l = n * a               # 末項:l  =  項数:n   * 公差:a
    return (a + l) * n / 2  # 総和:sn = (初項:a   + 末項:l) * 項数:n / 2

# 3 の倍数の合計
print sn(3, 999)
