import System.Environment ( getArgs )

type Command = [String]

getCommand :: Command -> IO String
getCommand (command:_) = return command
getCommand [] = return ""

getArguments :: Command -> IO [String]
getArguments (_:args) = return args
getArguments [] = return []

main :: IO ()
main = do
    raws <- getArgs
    command <- getCommand raws
    putStrLn $ "Command:\t" ++ command
    args <- getArguments raws
    putStrLn $ "Arguments:\t" ++ concat (head args : [" " ++ arg | arg <- tail args])