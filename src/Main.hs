import Control.Applicative ((<$>))
import Data.List (isInfixOf)

import Log.LogAnalysis
import Log.Log (LogMessage (..), MessageType (..))

contains :: String -> LogMessage -> Bool
contains x (LogMessage _ _ m) = x `isInfixOf` m

isError :: LogMessage -> Bool
isError (LogMessage (Error _) _ _) = True
isError _ = False

main = do
  logs <- parse <$> readFile "serverlogs.log"
  putStrLn $ unlines $ show <$> filter (contains "AirPort") logs
  putStrLn $ unlines $ show <$> filter (isError) logs
