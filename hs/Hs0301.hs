-- ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
sn::Int->Int->Int
sn a lim =
    let
        n = lim `div` a      -- ����:n  =  ���:lim / ����:a
        l = a * n            -- ����:l  =  ����:n   * ����:a
    in
        (a + l) * n `div` 2  -- ���a:sn = (����:a   + ����:l) * ����:n / 2

-- 3 �̔{���̍��v
main = putStrLn (show (sn 3 999))
