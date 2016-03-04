// ‘g‡‚¹
function Comb(n, r) {
    if (r == 0 || r == n)
        return 1
    else if (r == 1)
        return n
    else
        return Comb(n - 1, r - 1) + Comb(n - 1, r)
}

// ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
var n = 10
var r = 5
WScript.Echo(Comb(n, r))
