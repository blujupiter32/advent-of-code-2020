import Control.Monad

cast :: String -> Int
cast s = read s::Int

check :: [Int] -> Int
check p = (fromEnum ((sum p) == 2020)) * (foldl (*) 1 p)

main :: IO ()
main = readFile "input.txt" >>= (
  print . (\x -> x !! 0) . (filter (\x -> x > 0)) . (map check) . (replicateM 2)
  . (map cast) . lines
  )
