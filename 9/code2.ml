open Printf

let rec check xs x i di =
  let j = (i + di) in
  if j = (List.length xs) then
    if i = ((List.length xs) - 1) then
      false
    else
      check xs x (i + 1) 1
  else
    if ((List.nth xs i) + (List.nth xs j)) == x then
      true
    else
      check xs x i (di + 1)

let read ic =
  try
    int_of_string (input_line ic)
  with
    _ -> close_in_noerr ic; -1

let rec read_n xs ic n =
  match n with
    0 -> xs
  | _ ->
     try
       read_n (xs @ [(read ic)]) ic (n - 1)
     with
       _ -> xs

let rec step xs ic =
  match xs with
    [] -> step (read_n [] ic 25) ic
  | _ ->
     let x = read ic in
     if (check xs x 0 1) then
       match xs with
         _ :: tl ->
          step (tl @ [x]) ic
       | _ -> -1
     else x

let rec tweak xs x ic =
  match (compare (List.fold_left (+) 0 xs) x) with
    0 -> let xs2 = List.sort compare xs in
         (List.hd xs2) + (List.hd (List.rev xs2))
  | 1 -> (
    match xs with
      _ :: tl -> tweak tl x ic
    | _ -> -1
  )
  | -1 -> tweak (read_n xs ic 1) x ic
  | _ -> -1

let () =
  let ic = open_in "input.txt" in
  (
    let x = step [] ic in
    (
      seek_in ic 0;
      printf "%d\n" (tweak [read ic] x ic)
    );
    close_in ic
  )
