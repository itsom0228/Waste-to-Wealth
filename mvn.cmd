@REM Maven launcher script for Waste to Wealth project
@echo off
if exist "O:\Print With AI\.tools\apache-maven-3.9.6\bin\mvn.cmd" (
    "O:\Print With AI\.tools\apache-maven-3.9.6\bin\mvn.cmd" %*
) else (
    mvn %*
)
