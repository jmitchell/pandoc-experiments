---
title: Injecting JavaScript Code into a Web Page
author: Jacob Mitchell
date: 2017/02/19
...

# Targeting HTML

When Pandoc compiles this Markdown document to HTML using the
`web-script.hs` filter the following JavaScript code is injected into
a `<script>` tag.

```{.web-script .javascript}
alert("Hello, World!");
```

```bash
pandoc -f markdown -t html --filter web-script.hs -o index.html index.md
```

# Non-HTML Formats

If the target format isn't "html" or "html5" and the web filter isn't
used, the JavaScript gets injected as a normal code block. For example,

```bash
pandoc -t latex index.md
```

emits the following:

```latex
\section{Targeting HTML}\label{targeting-html}

When Pandoc compiles this Markdown document to HTML using the
\texttt{web-script.hs} filter the following JavaScript code is injected
into a \texttt{\textless{}script\textgreater{}} tag.

\begin{Shaded}
\begin{Highlighting}[]
\AttributeTok{alert}\NormalTok{(}\StringTok{"Hello, World!"}\NormalTok{)}\OperatorTok{;}
\end{Highlighting}
\end{Shaded}

\begin{Shaded}
% ...
```

However, if the `web-script.hs` filter *is* used, the `.web-script`
blocks are currently ignored completely.

```bash
pandoc -t latex --filter web-script.hs index.md
```

emits this instead:

```latex
\section{Targeting HTML}\label{targeting-html}

When Pandoc compiles this Markdown document to HTML using the
\texttt{web-script.hs} filter the following JavaScript code is injected
into a \texttt{\textless{}script\textgreater{}} tag.

If the target format isn't ``html'' or ``html5'' and the web filter
```
