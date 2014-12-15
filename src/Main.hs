import Control.Applicative ((<$>))
import Data.List (isInfixOf)

import Log.LogAnalysis
import Log.Log (LogMessage (..))

contains :: String -> LogMessage -> Bool
contains x (LogMessage _ _ m) = x `isInfixOf` m

main = do
  logs <- parse <$> readFile "serverlogs.log"
  putStrLn $ unlines $ show <$> filter (contains "AirPort") logs
