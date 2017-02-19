#!/bin/bash
pandoc -t html --filter web-script.hs -o index.html index.md
