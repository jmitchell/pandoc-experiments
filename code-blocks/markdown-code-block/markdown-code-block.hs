#!/usr/bin/env runhaskell
import Text.Pandoc.Definition       (Pandoc(..), Block(..), Format(..))
import Text.Pandoc.Error            (handleError)
import Text.Pandoc.JSON             (toJSONFilter)
import Text.Pandoc.Options          (def)
import Text.Pandoc.Readers.Markdown (readMarkdown)

asMarkdown :: String -> [Block]
asMarkdown contents =
  case handleError $ readMarkdown def contents of
    Pandoc _ blocks -> blocks

-- | Unwrap each CodeBlock with the "as-markdown" class, interpreting
-- its contents as Markdown.
markdownCodeBlock :: Maybe Format -> Block -> IO [Block]
markdownCodeBlock _ cb@(CodeBlock (_id, classes, _namevals) contents) =
  if "as-markdown" `elem` classes then
    return $ asMarkdown contents
  else
    return [cb]
markdownCodeBlock _ x = return [x]
  
main :: IO ()
main = toJSONFilter markdownCodeBlock
