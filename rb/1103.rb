# coding: Shift_JIS

N = 3

# Îpvfð\¦
def disp_eigenvalue(a)
    (0..N).each do |i|
        printf("%14.10f\t", a[i][i])
    end
    puts ""
end

# sñÌÏ
def multiply(a, b, c)
    (0..N).each do |i|
        (0..N).each do |j|
            s = 0.0
            (0..N).each do |k|
                s += a[i][k] * b[k][j]
            end
            c[i][j] = s
        end
    end
end

# LUªð
def decomp(a, l, u)
    (0..N).each do |i|
        (0..N).each do |j|
            l[i][j] = 0.0
            u[i][j] = 0.0
        end
    end

    l[0][0] = 1.0
    (0..N).each do |j|
        u[0][j] = a[0][j]
    end

    (1..N).each do |i|
        u[i][0] = 0.0
        l[0][i] = 0.0
        l[i][0] = a[i][0] / u[0][0]
    end

    (1..N).each do |i|
        l[i][i] = 1.0
        t = a[i][i]
        (0..i).each do |k|
            t -= l[i][k] * u[k][i]
        end
        u[i][i] = t
        ((i + 1)..N).each do |j|
            u[j][i] = 0.0
            l[i][j] = 0.0
            t       = a[j][i]
            (0..i).each do |k|
                t -= l[j][k] * u[k][i]
            end
            l[j][i] = t / u[i][i]
            t       = a[i][j]
            (0..i).each do |k|
                t -= l[i][k] * u[k][j]
            end
            u[i][j] = t
        end
    end
end

# LRªðÅÅLlðßé

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
l = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]
u = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]

(1..200).each do |k|
    # LUªð
    decomp(a, l, u)
    # sñÌÏ
    multiply(u, l, a)
    # Îpvfð\¦
    printf("%3d\t", k)
    disp_eigenvalue(a)

    # û©»è
    e = 0.0
    (1..N).each do |i|
        (0..(i - 1)).each do |j|
            e += (a[i][j]).abs
        end
    end
    break if (e < 0.00000000001)
end

puts ""
puts "eigenvalue"
disp_eigenvalue(a)
