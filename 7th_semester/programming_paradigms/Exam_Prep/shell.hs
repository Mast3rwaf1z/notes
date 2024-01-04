import System.IO (hFlush, stdout)

type Command = [String]
type Configuration = [(String, String)]

getValue :: Configuration -> String -> String
getValue ((key, value):xs) target | key == target = value
                                  | otherwise     = getValue xs target
getValue [] _ = ""

setValue :: Configuration -> String -> String -> Configuration
setValue [] targetKey targetValue = [(targetKey, targetValue)]
setValue ((key, value):xs) targetKey targetValue | key == targetKey = (targetKey, targetValue) : xs
                                                 | otherwise        = (key, value) : setValue xs targetKey targetValue

getCmd :: IO Command
getCmd = do
    words <$> getLine

setter :: Configuration -> String -> String -> IO String
setter c "prompt" prompt = do
    shell (setValue c "prompt" (prompt ++ " "))
    return "exit"
setter c "printenable" "1" = do
    setter c "printenable" "true"
setter c "printenable" "0" = do
    setter c "printenable" "false"
setter c "printenable" "yes" = do
    setter c "printenable" "true"
setter c "printenable" "no" = do
    setter c "printenable" "false"
setter c key value = do
    shell (setValue c key value)
    return "exit"

indent :: String
indent = "\r\t\t\t"
newline :: String
newline = "\n"

execute :: Configuration -> Command -> IO String
execute c ["ls"] = do
    return "Files in this directory:"
execute c ["math"] = do
    return "add|subtract|multiply|divide|modulus [0-9]* [0-9]*"
execute c ["math", "add", arg1, arg2] = do
    return (show (read arg1 + read arg2))
execute c ["math", "subtract", arg1, arg2] = do
    return (show (read arg1 - read arg2))
execute c ["math", "multiply", arg1, arg2] = do
    return (show (read arg1 * read arg2))
execute c ["math", "divide", arg1, "0"] = do
    return "Error, divide by 0"
execute c ["math", "divide", arg1, arg2] = do
    return (show (read arg1 / read arg2))
execute c ["math", "modulus", arg1, arg2] = do
    return (show (mod (read arg1) (read arg2)))
execute c ["help"] = do
    return $ "Haskell funny shell!"                                             ++ newline ++
             "\tls"   ++ indent ++ "Lists all files in directory"               ++ newline ++
             "\tmath" ++ indent ++ "Performs mathematical operations (+-*/%)"   ++ newline ++
             "\thelp" ++ indent ++ "Shows this help message"                    ++ newline ++
             "\tset"  ++ indent ++ "Sets a property and reloads the shell"      ++ newline ++
             "\tshow" ++ indent ++ "Shows the configuration"                    ++ newline ++
             "\texit" ++ indent ++ "Exits the shell"
execute c ["exit"] = do
    return "exit"
execute c ["set",key,value] = do
    setter c key value
execute [] ["show"] = return ""
execute ((key, value):xs) ["show"] = do
    result <- execute xs ["show"]
    return $ key ++ "\r\t\t->\t" ++ value ++ "\n" ++ result
execute c (x:xs) = do
    return $ "No such command! [" ++ x ++ (concat [" " ++ x | x <- xs]) ++ "]"
execute c [] = return ""


shell :: Configuration -> IO ()
shell configuration = do
    putStr (getValue configuration "prompt")
    hFlush stdout
    cmd <- getCmd
    result <- execute configuration cmd
    if result == "exit" then
        return ()
    else do
        putStr (if getValue configuration "printenable" /= "false" then result ++ "\n" else "")
        shell configuration

main :: IO ()
main = shell [("prompt", "> ")]