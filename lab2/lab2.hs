import Control.Exception

import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO.Error (isUserError, ioeGetErrorString)

import CMM.Lex
import CMM.Par
import CMM.ErrM

import TypeChecker
import Interpreter

-- | Parse, type check, and interpret a program given by the @String@.

check :: String -> IO ()
check s = do
<<<<<<< HEAD:lab2/lab2.hs
  if s == [] then do
          putStrLn "TYPE ERROR"
          exitFailure
  else do
  case pProgram (myLexer s) of
    Bad err  -> do
      putStrLn "SYNTAX ERROR"
      putStrLn err
      exitFailure
    Ok  tree -> do
      case typecheck tree of
=======
  case s of
    [] -> case pProgram (myLexer "void worthless(){}") of 
      Ok tree -> case typecheck tree of
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/lab2.hs
        Bad err -> do
          putStrLn "TYPE ERROR"
          putStrLn err
          exitFailure
<<<<<<< HEAD:lab2/lab2.hs
        Ok _ -> catchJust (\e -> if isUserError e then Just (ioeGetErrorString e) else Nothing) (interpret tree) $
          \err -> do
            putStrLn "INTERPRETER ERROR"
            putStrLn err
            exitFailure
=======
    _  -> case pProgram (myLexer s) of
            Bad err  -> do
              putStrLn "SYNTAX ERROR"
              putStrLn err
              exitFailure
            Ok tree -> do
              case typecheck tree of
                  Bad err -> do
                      putStrLn "TYPE ERROR"
                      putStrLn err
                      exitFailure
                  Ok _ -> interpret tree
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/lab2.hs

-- | Main: read file passed by only command line argument and call 'check'.

main :: IO ()
main = do
  args <- getArgs
  case args of
    [file] -> readFile file >>= check
    _      -> do
      putStrLn "Usage: lab2 <SourceFile>"
      exitFailure
