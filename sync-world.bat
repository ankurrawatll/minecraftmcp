@echo off
REM Minecraft World Sync Script
REM Usage: sync-world.bat [pull|push] [commit message]

if "%1"=="pull" (
    echo Pulling latest world files from GitHub...
    git pull origin main
    if %errorlevel% equ 0 (
        echo World files updated successfully!
    ) else (
        echo Error pulling world files. Please check your connection and try again.
        pause
        exit /b 1
    )
) else if "%1"=="push" (
    echo Adding world files...
    git add world/
    
    if "%2"=="" (
        set "commit_msg=Update world files - %date% %time%"
    ) else (
        set "commit_msg=%2"
    )
    
    echo Committing changes...
    git commit -m "%commit_msg%"
    
    if %errorlevel% equ 0 (
        echo Pushing to GitHub...
        git push origin main
        if %errorlevel% equ 0 (
            echo World files pushed successfully!
        ) else (
            echo Error pushing to GitHub. Please check your connection and try again.
            pause
            exit /b 1
        )
    ) else (
        echo No changes to commit or commit failed.
        pause
        exit /b 1
    )
) else (
    echo Usage:
    echo   sync-world.bat pull                    - Pull latest world files
    echo   sync-world.bat push "commit message"  - Push world files with message
    echo   sync-world.bat push                   - Push world files with auto message
    exit /b 1
)

pause

