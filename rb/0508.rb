# ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
def mySinh(x, n, numerator, denominator, y)
    m           = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator * x * x
    a           = numerator / denominator
    # \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    if (a.abs <= 0.00000000001)
        y
    else
        y + mySinh(x, n + 1, numerator, denominator, a)
    end
end

(0..20).each do |i|
    x = i - 10
    # ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    d1     = mySinh(x, 1, x, 1.0, x)
    # •W€‚Ì‘o‹Èü³Œ·ŠÖ”
    d2     = Math.sinh(x)
    # •W€ŠÖ”‚Æ‚Ì·ˆÙ
    printf("%3d : %17.10f - %17.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
