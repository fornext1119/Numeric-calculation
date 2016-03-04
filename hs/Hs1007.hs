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

-- 前進消去
forward_elim_loop::Int->Int->[[Double]]->[[Double]]
forward_elim_loop pivot col a = 
    let
        a_zip = zip [0..col] $ zip (take col (a!!pivot)) (take col (a!!col))
        s     = sum $ map(\(k, (a_pivot, a_col)) -> a_pivot * a_col * (a!!k!!k)) a_zip
        a_col = (a!!pivot!!col - s) / (a!!col!!col)

        a_row = (take col   (a!!pivot)) ++ (a_col:(drop (col+1)   (a!!pivot)))
        a_piv = (take pivot (a!!col  )) ++ (a_col:(drop (pivot+1) (a!!col)))

        a1 = (take col   a ) ++ (a_piv:(drop (col+1)   a))
        a2 = (take pivot a1) ++ (a_row:(drop (pivot+1) a))

        next_col = if col + 1 == pivot then pivot + 1
                                       else col   + 1
    in
        if next_col < pivot then forward_elim_loop pivot next_col a2
                            else a2

forward_elimination::Int->[[Double]]->[[Double]]
forward_elimination pivot a = 
    let
        next_col = if pivot == 0 then 1
                                 else 0
        a1    = forward_elim_loop pivot next_col a
        s     = sum $ map(\(k, col) -> col * col * a1!!k!!k) $ zip [0..pivot] $ take pivot (a1!!pivot)
        a_col = a1!!pivot!!pivot - s

        a_row = (take pivot (a1!!pivot)) ++ (a_col:(drop (pivot+1) (a1!!pivot)))
        a2    = (take pivot a1         ) ++ (a_row:(drop (pivot+1) a1         ))
    in
        if pivot < (n - 1)
            then forward_elimination (pivot+1) a2
            else a2

-- 前進代入
forward_substitution::Int->[[Double]]->[Double]->[Double]
forward_substitution row a b = 
    let
        a_zip = zip (take row (a!!row)) b
        s  = sum $ map(\(a_col, b_col) -> a_col * b_col) a_zip
        y  = (b!!row - s)
        b2 = (take row b) ++ (y:(drop (row+1) b))
    in
        if row < (n - 1)
            then y:(forward_substitution (row+1) a b2)
            else y:[]

-- 後退代入
backward_substitution::Int->[[Double]]->[Double]->[Double]
backward_substitution row a b = 
    let
        a_zip = zip (drop (row+1) (a!!row)) (drop (row+1) b)
        s  = sum $ map(\(a_col, b_col) -> a_col * a!!row!!row * b_col) a_zip
        x  = (b!!row - s) / (a!!row!!row)
        b2 = (take row b) ++ (x:(drop (row+1) b))
    in
        if row > 0
            then x:(backward_substitution (row-1) a b2)
            else x:[]

main = do
    let a  = [[5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20::Double]]
    let b  = [34,68,96,125::Double]

    putStrLn "A"
    disp_matrix a
    putStrLn "B"
    disp_vector b
    putStrLn ""

    -- 前進消去
    let a2 = forward_elimination 0 a

    putStrLn "LDL^T"
    disp_matrix a2

    -- Ly=b から y を求める (前進代入)
    let y = forward_substitution 0 a2 b

    putStrLn "Y"
    disp_vector y

    -- DL^Tx=y から x を求める (後退代入)
    let x = backward_substitution (n-1) a2 y

    putStrLn "X"
    disp_vector (reverse x)
