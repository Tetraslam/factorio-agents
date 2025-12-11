@echo off
echo Fetching upstream changes (JackHopkins/factorio-learning-environment)...
echo.

cd /d "%~dp0"

echo Fetching upstream changes...
git fetch upstream
if errorlevel 1 goto error

echo.
echo === NEW COMMITS FROM UPSTREAM ===
git log HEAD..upstream/main --oneline
echo.

echo === CHANGED FILES ===
git diff --stat HEAD..upstream/main
echo.

set /p CONFIRM="Merge these changes locally? (y/n): "
if /i not "%CONFIRM%"=="y" goto cancelled

echo.
echo Merging upstream/main into local branch...
git merge upstream/main -m "Merge upstream changes"
if errorlevel 1 goto conflict

echo.
echo Done! Changes merged locally.
echo.
echo To push to your GitHub fork, run:
echo   git push origin main
goto end

:cancelled
echo.
echo Cancelled. No changes made.
goto end

:conflict
echo.
echo MERGE CONFLICT detected. Resolve conflicts manually, then run:
echo   git add .
echo   git commit -m "Resolved merge conflicts"
goto end

:error
echo.
echo An error occurred. Check the output above.

:end
echo.
pause

