main = do
  logs <- readFile "serverlogs.log"
  putStrLn $ head $ lines logs
