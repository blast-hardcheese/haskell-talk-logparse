import Control.Applicative ((<$>))
import Data.List (isInfixOf, sortBy)

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

sortMessages :: [LogMessage] -> [LogMessage]
sortMessages = sortBy compareMsgs
  where compareMsgs :: LogMessage -> LogMessage -> Ordering
        compareMsgs (LogMessage _ l _) (LogMessage _ r _) = compare l r


main = do
  logs <- parse <$> readFile "serverlogs.log"
  putStrLn $ unlines $ show <$> filter (contains "AirPort") logs
  putStrLn $ unlines $ show <$> demoteUnimportant 30 <$> filter (isError) logs

  logs <- parse <$> readFile "serverlogs-async.log"
  putStrLn $ unlines $ fmap show $ filter (isError) $ (demoteUnimportant 30) <$> sortMessages logs
  putStrLn $ unlines $ fmap show $ sortMessages $ filter (isError) $ (demoteUnimportant 30) <$> logs
