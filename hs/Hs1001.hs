import Text.Printf
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

-- ヤコビの反復法
row_loop::Int->[[Double]]->[Double]->[Double]->[Double]->[Double]
row_loop row a b x0 x1 =
    let
        a1 = zip (a!!row) x0
        a2 = take row a1 ++ drop (row + 1) a1
        a3 = map (\(x, y) -> x * y) $ a2
        s  = sum a3
        x  = ((b!!row) - s) / a!!row!!row
        xs = x:x1
    in
        if row >= (n - 1) 
            then
                reverse xs
            else
                (row_loop (row+1) a b x0 xs)

jacobi::[[Double]]->[Double]->[Double]->[[Double]]->([[Double]],[Double])
jacobi a b x0 xs =
    let
        x1  = (row_loop 0 a b x0 [])
        cnt = length $ filter (>= 0.0000000001) $ map (\(x,y) -> abs(x - y)) $ zip x0 x1
    in
        if cnt < 1
            then 
                (reverse xs, x1)
            else 
                (jacobi a b x1 (x1:xs))

main = do
    let a  = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6::Double]]
    let b  = [20,16,8,17::Double]
    let x0 = [0,0,0,0::Double]

    -- ヤコビの反復法
    let (xs, x1) = jacobi a b x0 []
    disp_matrix xs

    putStrLn "X"
    disp_vector x1
