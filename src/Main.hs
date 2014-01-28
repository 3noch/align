module Main where

import Data.List (intercalate, transpose)
import Data.List.Split (splitOn)
import Data.Version (showVersion)
import Options.Applicative

import Paths_align (version)


data CmdOptions = CmdOptions
  { _delim   :: String }


(<$$>) :: (Functor f, Functor f1) => (a -> b) -> f (f1 a) -> f (f1 b)
(<$$>) = fmap . fmap


cmdOptions :: Parser CmdOptions
cmdOptions = CmdOptions
  <$> strOption
      ( long    "delimiter"
     <> short   'd'
     <> metavar "DELIM"
     <> value   ","
     <> showDefault
     <> help    "Use DELIM to delimit columns in the input" )


go :: CmdOptions -> IO ()
go (CmdOptions delim) = interact $ unlines . (intercalate delim <$>) . f . (splitOn delim <$>) . lines
  where
    f :: [[String]] -> [[String]]
    f xss = [(align <$> zip maxWidths xs) ++ [last xs] | xs <- xss]
      where
        align (m, x) = x ++ replicate (m - length x) ' '
        maxWidths = maximum <$> length <$$> transpose (init <$> xss)


addVersion :: Parser (a -> a)
addVersion = infoOption ("align version " ++ showVersion version)
  ( long "version"
  <> help "Show version information" )


main :: IO ()
main = execParser opts >>= go
  where
    opts = info (helper <*> addVersion <*> cmdOptions)
      ( fullDesc
     <> progDesc "Align all the columns in a file to be left justified" )
