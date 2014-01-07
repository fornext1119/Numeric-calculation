import Text.Printf
import Control.Monad

-- �f�[�^�_�̐� - 1
n   =  6 :: Int
nx2 = 13 :: Int

-- ���̊֐�
f::Double->Double
f x = x - (x ^ 3) / (fromIntegral (3 * 2)) + (x ^ 5) / (fromIntegral (5 * 4 * 3 * 2))

-- ���֐�
fd::Double->Double
fd x = 1.0 - (x ^ 2) / (fromIntegral 2) + (x ^ 4) / (fromIntegral (4 * 3 * 2))

-- Hermite (�G���~�[�g) ���
hermite::Double->[Double]->[Double]->Double
hermite d z a =
    let sum_list = map(\i -> do
        let prod_list = map(\j -> do
            d - z!!j
            ) $ [0..(i-1)::Int]
        product $ a!!i : prod_list
        ) [1..nx2::Int]
    in
        sum $ a!!0 : sum_list

-- �������̕\�����
make_table::[Double]->[Double]->[Double]->[Double]->Int->[Double]
make_table yd z d a i =
    let
        w = map(\j -> do
            if (i == 1 && (rem j 2) == 0) then
                yd!!(div j 2)
            else
                ((d!!(j+1) - d!!j) / (z!!(j+i) - z!!j))
            ) $ [0..(nx2-i)::Int]
        t = w!!0:a
    in
        -- ���K������
        if i == nx2 then t
                    else (make_table yd z w t (i + 1))

main = do
    -- 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    let x  = map(\i -> (fromIntegral i) * 1.5 - 4.5) [0..n]
    let y  = map(\i -> f(i)) x
    let yd = map(\i -> fd(i)) x
    
    -- �������̕\�����
    let z = map(\i -> x!!(div i 2)) [0..nx2]
    let w = map(\i -> y!!(div i 2)) [0..nx2]
    let a = reverse (make_table yd z w [w!!0] 1)
    
    -- 0.5���݂� �^�����Ă��Ȃ��l����
    let d1 = map(\i -> (fromIntegral i) * 0.5 - 4.5) [0..18]
    let d2 = map(\i -> (f i)) d1
    let d3 = map(\i -> (hermite i z a)) d1

    forM_ (zip (zip d1 d2) d3) $ \((d1, d2), d3) -> do
        printf "%5.2f\t%8.5f\t%8.5f\t%8.5f\n" d1 d2 d3 (d2 - d3)
