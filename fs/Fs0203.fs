[1..99]
|> List.filter (fun x -> x % 3 = 0)
|> List.reduce(+)
[1..99]
|> List.filter (fun x -> x % 3 = 0)
|> List.sum
