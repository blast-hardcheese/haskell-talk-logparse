import Control.Applicative ((<$>))
import Data.List (isInfixOf)

import Log.LogAnalysis
import Log.Log (LogMessage (..), MessageType (..))

contains :: String -> LogMessage -> Bool
contains x (LogMessage _ _ m) = x `isInfixOf` m

isError :: LogMessage -> Bool
isError (LogMessage (Error _) _ _) = True
isError _ = False

demoteUnimportant :: Int -> LogMessage -> LogMessage
demoteUnimportant limit lm@(LogMessage (Error lvl) ts msg) | lvl < limit = LogMessage Warning ts msg
demoteUnimportant _ lm = lm

main = do
  logs <- parse <$> readFile "serverlogs.log"
  putStrLn $ unlines $ show <$> filter (contains "AirPort") logs
  putStrLn $ unlines $ show <$> demoteUnimportant 30 <$> filter (isError) logs
