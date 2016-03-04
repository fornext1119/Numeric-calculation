import Text.Printf
import Debug.Trace
import Control.Monad

n = 4::Int

-- ２次元配列を表示
disp_matrix::[[Double]]->IO()
disp_matrix matrix = do
    forM_ matrix $ \row -> do
        forM_ row $ \elem -> do
            printf "%14.10f\t" elem
        putStrLn ""

-- １次元配列を表示
disp_vector::[Double]->IO()
disp_vector vector = do
    forM_ vector $ \elem -> do
        printf "%14.10f\t" elem 
    putStrLn ""

-- 各列で 一番値が大きい行を 探す
get_max_row::Int->Int->[[Double]]->Int->Double->(Int, Double)
get_max_row row col a max_row max_val =
    let
        -- 一番値が大きい行
        (max_row2, max_val2) = 
            if max_val < abs(a!!row!!col)
                then (row,     abs(a!!row!!col))
                else (max_row, max_val)
    in
        if row >= length(a) - 1
            then
                (max_row2, max_val2)
            else
                get_max_row (row+1) col a max_row2 max_val2

-- ピボット選択
pivoting::Int->[[Double]]->[Double]->[[Double]]->[Double]->([[Double]],[Double])
pivoting pivot a b a2 b2 = 
    let
        (max_row, max_val) = get_max_row 0 pivot a 0 0.0
        a3 = (a!!max_row):a2
        b3 = (b!!max_row):b2
        a4 = (take (max_row) a) ++ (drop (max_row+1) a)
        b4 = (take (max_row) b) ++ (drop (max_row+1) b)
    in
        if pivot >= (n - 1)
            then
                (reverse a3, reverse b3)
            else
                pivoting (pivot+1) a4 b4 a3 b3
 
-- 前進消去
forward_elim_loop::Int->Int->[[Double]]->[Double]->([[Double]],[Double])
forward_elim_loop pivot row a b = 
    let
        s = a!!row!!pivot / a!!pivot!!pivot

        a_zip   = zip (a!!pivot) (a!!row)
        new_row = map (\(a_pivot, a_row) -> a_row - a_pivot * s) a_zip
        a2      = (take row a) ++ (new_row:(drop (row+1) a))

        x  = b!!row - b!!pivot * s
        b2 = (take row b) ++ (x:(drop (row+1) b))
        
        next_row = 
            if row + 1 == pivot
                then row + 2
                else row + 1                
    in
        if next_row < n
            then
                forward_elim_loop pivot next_row a2 b2
            else
                (a2, b2)

forward_elimination::Int->[[Double]]->[Double]->([[Double]],[Double])
forward_elimination pivot a b = 
    let
        row = if pivot == 0 then 1 else 0    
        (a2, b2) = 
            if pivot < n
                then forward_elim_loop pivot row a b
                else (a, b)
    in
        if pivot < (n - 1)
            then
                forward_elimination (pivot+1) a2 b2
            else
                (a2, b2)

-- 後退代入
backward_substitution::Int->[[Double]]->[Double]->[Double]
backward_substitution row a b = 
    let
        x  = b!!row / (a!!row!!row)
        b2 = (take row b) ++ (x:(drop (row+1) b))
    in
        if row > 0
            then x:(backward_substitution (row-1) a b2)
            else x:[]

main = do
    let a  = [[-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1::Double]]
    let b  = [8,17,20,16::Double]

    -- ピボット選択
    let (a1, b1) = pivoting 0 a b [] []

    putStrLn "pivoting"
    putStrLn "A"
    disp_matrix a1
    putStrLn "B"
    disp_vector b1
    putStrLn ""

    -- 前進消去
    let (a2, b2) = forward_elimination 0 a1 b1

    putStrLn "forward elimination"
    putStrLn "A"
    disp_matrix a2
    putStrLn "B"
    disp_vector b2
    putStrLn ""

    -- 後退代入
    let x = backward_substitution (n-1) a2 b2

    putStrLn "X"
    disp_vector (reverse x)
