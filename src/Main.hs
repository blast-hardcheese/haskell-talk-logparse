import Control.Applicative ((<$>))

import Log.LogAnalysis

main = do
  logs <- parse <$> readFile "serverlogs.log"
  putStrLn $ head $ show <$> logs
