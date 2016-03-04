[0..9]
[0..9]
|> List.map (fun n -> n * 3 + 5)
[0L..9L]
|> List.map (fun n -> n * 3L + 5L)
|> List.reduce(*)
