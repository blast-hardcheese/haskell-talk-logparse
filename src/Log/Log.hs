module Log.Log where

import Control.Applicative ((<$>))

data MessageType = Info
                 | Warning
                 | Error Int
  deriving (Show, Eq)

type TimeStamp = Int

data LogMessage = LogMessage MessageType TimeStamp String
  deriving (Show, Eq)
