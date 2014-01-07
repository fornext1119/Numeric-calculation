import Text.Printf
import Control.Monad

-- �f�[�^�_�̐� - 1
n = 6 :: Int

-- ���̊֐�
f::Double->Double
f x = x - (x ^ 3) / (fromIntegral (3 * 2)) + (x ^ 5) / (fromIntegral (5 * 4 * 3 * 2))

-- Lagrange (���O�����W��) ���
lagrange::Double->[Double]->[Double]->Double
lagrange d x y =
    let sum_list = map(\i -> do
        let prod_list = map(\j -> do
            (d - x!!j) / (x!!i - x!!j)
            ) $ filter (\j -> j /= i) [0..n::Int]
        product $ y!!i : prod_list
        ) [0..n::Int]
    in
        sum $ sum_list

main = do
    -- 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    let x = map(\i -> (fromIntegral i) * 1.5 - 4.5) [0..n]
    let y = map(\i -> f(i)) x

    -- 0.5���݂� �^�����Ă��Ȃ��l����
    let d1 = map(\i -> (fromIntegral i) * 0.5 - 4.5) [0..18]
    let d2 = map(\i -> (f i)) d1
    let d3 = map(\i -> (lagrange i x y)) d1

    forM_ (zip (zip d1 d2) d3) $ \((d1, d2), d3) -> do
        printf "%5.2f\t%8.5f\t%8.5f\t%8.5f\n" d1 d2 d3 (d2 - d3)
