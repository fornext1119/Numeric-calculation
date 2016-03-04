module Fs0105

let mutable sm = 0
for i in [1..99] do
    if (i % 3 = 0) then
        sm <- sm + i

printfn "%d" sm

exit 0
