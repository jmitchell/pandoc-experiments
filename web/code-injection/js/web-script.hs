#!/usr/bin/env runhaskell
import Text.Pandoc.Builder
import Text.Pandoc.JSON

webFormats :: [String]
webFormats =
  [ "html"
  , "html5"
  ]

script :: String -> Block
script src = Para $ toList $ rawInline "html" ("<script type='application/javascript'>" <> src <> "</script>")

-- TODO: Add class/nameval to support rendering code block as well.
injectScript :: Maybe Format -> Block -> IO Block
injectScript (Just (Format format)) cb@(CodeBlock (_id, classes, _namevals) contents) =
  if "web-script" `elem` classes then
    -- TODO: make behavior configurable (e.g. fail fast or inject
    -- "unsupported context" message)
    if format `elem` webFormats then
      return $ script contents
    else
      return Null
  else
    return cb
injectScript _ x = return x

main :: IO ()
main = toJSONFilter injectScript
