@echo off

mkdocs -q build && git add . && git commit -m "%*" && git push