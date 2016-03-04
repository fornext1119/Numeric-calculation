import Text.Printf
import Control.Monad

-- �f�[�^�_�̐� - 1
n = 6 :: Int

-- ���̊֐�
f::Double->Double
f x = x - (x ^ 3) / (fromIntegral (3 * 2)) + (x ^ 5) / (fromIntegral (5 * 4 * 3 * 2))

-- Newton (�j���[�g��) ���
newton::Double->[Double]->[Double]->Double
newton d x a =
    let sum_list = map(\i -> do
        let prod_list = map(\j -> do
            d - x!!j
            ) $ [0..(i-1)::Int]
        product $ a!!i : prod_list
        ) [1..n::Int]
    in
        sum $ a!!0 : sum_list

-- �������̕\�����
make_table::[Double]->[Double]->[Double]->Int->[Double]
make_table x d a i =
    let
        w = map(\j -> do
            ((d!!(j+1) - d!!j) / (x!!(j+i) - x!!j))
            ) $ [0..(n-i)::Int]
        t = w!!0:a
    in
        -- ���K������
        if i == n then t
                  else (make_table x w t (i + 1))

main = do
    -- 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    let x = map(\i -> (fromIntegral i) * 1.5 - 4.5) [0..n]
    let y = map(\i -> f(i)) x
    
    -- �������̕\�����
    let a = reverse (make_table x y [y!!0] 1)
    
    -- 0.5���݂� �^�����Ă��Ȃ��l����
    let d1 = map(\i -> (fromIntegral i) * 0.5 - 4.5) [0..18]
    let d2 = map(\i -> (f i)) d1
    let d3 = map(\i -> (newton i x a)) d1

    forM_ (zip (zip d1 d2) d3) $ \((d1, d2), d3) -> do
        printf "%5.2f\t%8.5f\t%8.5f\t%8.5f\n" d1 d2 d3 (d2 - d3)
