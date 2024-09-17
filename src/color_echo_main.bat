@echo off
@REM setlocal

:loop_args
set "arg1=%~1"
@REM echo arg1=%arg1%

if "%~1" == "" (
    goto :loop_args_end
) 

if "%~1" == "--help" (
    call :show_help
    goto :eof
) else if "%~1" == "ensure-support" (
    call :ensure_support 1
    if ERRORLEVEL 1 (
        exit /b 1
    )
) else if "%~1" == "define" (
    call :color_define
) else if "%~1" == "init" (
    call :init
) else if "%~1" == "re-init" (
    set flag_color_echo_inited=false
    call :init
) else if "%arg1:~0,1%" == ":" (
    goto %arg1% 
    if ERRORLEVEL 1 (
        exit /b 1
    )
) else (
    echo No such command: "%arg1%"
    exit /b 1
)

shift /1
goto :loop_args

:loop_args_end

@REM cmd

goto :eof


:show_help
    set color_echo_version=1.0.0
    set color_echo_author=LiuJiewenTT
    echo color_echo v%color_echo_version%, developed by %color_echo_author%.
    echo.
    echo Usage: color_echo [options] commands
    echo.
    echo Options:
    echo   --help           Show this help message
    echo.
    echo Commands:
    echo   ensure-support   Enable ANSI escape sequence support ^(Windows 10 and later^)
    echo   init             Initialize color_echo
    echo   re-init          Re-Initialize color_echo
    echo   define           Define color aliases
goto :eof


:color_define
    call color_echo_define.bat
goto :eof


:ensure_support
    @REM 启用ANSI转义序列支持 
    @REM param 1: 传入1表示确认“确保”，传入0表示不需要“确保” 

    reg query HKCU\Console /v VirtualTerminalLevel >nul 2>&1
    if ERRORLEVEL 1 if /I "%~1" == "1" (
        reg add HKCU\Console /f /v VirtualTerminalLevel /t REG_DWORD /d 1 >nul
    ) else (
        echo [ERROR]: ANSI escape sequence support is not enabled.
        exit /b 1
    )
goto :eof


:load_screen_color
:load_screen_color_from_reg_config
    @REM set console_reg_config=HKEY_CURRENT_USER\Console\%%SystemRoot%%_system32_cmd.exe
    set console_reg_config_default=HKEY_CURRENT_USER\Console
    if not defined console_config (
        set console_reg_config=%console_reg_config_default%
    )
    echo [INFO]: console_reg_config=%console_reg_config%
    @REM reg query "%console_reg_config%" /v "ScreenColors"
    for /f "usebackq tokens=3 delims= " %%A in (
        `reg query "%console_reg_config%" /v "ScreenColors"`
    ) do (
        set "screen_color=%%A"
    )
    if defined screen_color (
        set "screen_color=%screen_color:~2,2%"
    )
    call :resolve_screen_color
    exit /b %errorlevel%
goto :eof


:resolve_screen_color
    if defined screen_color (
        set "fg_color=%screen_color:~-2,1%"
        set "bg_color=%screen_color:~-1,1%"
    ) else (
        exit /b 1
    )
    if /I "%fg_color%" == "%bg_color%" if /I "%fg_color%" NEQ "0" (
        set fg_color=0
    ) else (
        set fg_color=f
    )
goto :eof


:reset_fg_bg_default_color
    set flag_fg_bg_defined=false
    if defined fg_color if defined bg_color (
        set flag_fg_bg_defined=true
    )
    if "%flag_fg_bg_defined%" == "true" (
        call :get_color_by_number "FG" %fg_color%
        call :reset_fg_bg_default_color_set_FG
        call :get_color_by_number "BG" %bg_color%
        call :reset_fg_bg_default_color_set_BG
    )
    set get_color_by_number_retv=
    set flag_fg_bg_defined=
    goto :eof

    :reset_fg_bg_default_color_set_FG
        set FG_RESET=%get_color_by_number_retv%
    goto :eof

    :reset_fg_bg_default_color_set_BG
        set BG_RESET=%get_color_by_number_retv%
    goto :eof
goto :eof


:init
    if "%flag_color_echo_inited%" == "true" (
        echo [INFO]: Already inited.
        exit /b 0
    )
    set flag_color_echo_inited=true
    call :color_define
    if defined screen_color (
        call :resolve_screen_color
    ) else (
        call :load_screen_color
    )
    call :reset_fg_bg_default_color
    exit /b %errorlevel%
goto :eof


:check_delayedexpansion
    set something=!some_var!
    if "%something%" == "!some_var!" (
        echo [INFO]: Delayed expansion is not enabled.
        set flag_delayedexpansion_status=disabled
        exit /b 1
    ) else (
        echo [INFO]: Delayed expansion is enabled.
        set flag_delayedexpansion_status=enabled
        exit /b 0
    )
goto :eof


:get_color_by_number
    if /I "%~1" == "FG" (
        set flag_get_color_by_number_type=FG
    ) else if /I "%~1" == "BG" (
        set flag_get_color_by_number_type=BG
    ) else (
        echo [ERROR]: get_color_by_number: Invalid color type.
        exit /b 1
    )
    if not defined flag_delayedexpansion_status (
        call :check_delayedexpansion
    )
    
    if "%flag_delayedexpansion_status%" == "enabled" (
        set get_color_by_number_retv=!%flag_get_color_by_number_type%_COLOR_%~2!
    ) else (
        goto label_get_color_by_number_%flag_get_color_by_number_type%_%~2
        :label_get_color_by_number_FG_0
        set get_color_by_number_retv=%FG_COLOR_0%
        goto :eof
        :label_get_color_by_number_FG_1
        set get_color_by_number_retv=%FG_COLOR_1%
        goto :eof
        :label_get_color_by_number_FG_2
        set get_color_by_number_retv=%FG_COLOR_2%
        goto :eof
        :label_get_color_by_number_FG_3
        set get_color_by_number_retv=%FG_COLOR_3%
        goto :eof
        :label_get_color_by_number_FG_4
        set get_color_by_number_retv=%FG_COLOR_4%
        goto :eof
        :label_get_color_by_number_FG_5
        set get_color_by_number_retv=%FG_COLOR_5%
        goto :eof
        :label_get_color_by_number_FG_6
        set get_color_by_number_retv=%FG_COLOR_6%
        goto :eof
        :label_get_color_by_number_FG_7
        set get_color_by_number_retv=%FG_COLOR_7%
        goto :eof
        :label_get_color_by_number_FG_8
        set get_color_by_number_retv=%FG_COLOR_8%
        goto :eof
        :label_get_color_by_number_FG_9
        set get_color_by_number_retv=%FG_COLOR_9%
        goto :eof
        :label_get_color_by_number_FG_a
        :label_get_color_by_number_FG_10
        set get_color_by_number_retv=%FG_COLOR_10%
        goto :eof
        :label_get_color_by_number_FG_b
        :label_get_color_by_number_FG_11
        set get_color_by_number_retv=%FG_COLOR_11%
        goto :eof
        :label_get_color_by_number_FG_c
        :label_get_color_by_number_FG_12
        set get_color_by_number_retv=%FG_COLOR_12%
        goto :eof
        :label_get_color_by_number_FG_d
        :label_get_color_by_number_FG_13
        set get_color_by_number_retv=%FG_COLOR_13%
        goto :eof
        :label_get_color_by_number_FG_e
        :label_get_color_by_number_FG_14
        set get_color_by_number_retv=%FG_COLOR_14%
        goto :eof
        :label_get_color_by_number_FG_f
        :label_get_color_by_number_FG_15
        set get_color_by_number_retv=%FG_COLOR_15%
        goto :eof
        :label_get_color_by_number_BG_0
        set get_color_by_number_retv=%BG_COLOR_0%
        goto :eof
        :label_get_color_by_number_BG_1
        set get_color_by_number_retv=%BG_COLOR_1%
        goto :eof
        :label_get_color_by_number_BG_2
        set get_color_by_number_retv=%BG_COLOR_2%
        goto :eof
        :label_get_color_by_number_BG_3
        set get_color_by_number_retv=%BG_COLOR_3%
        goto :eof
        :label_get_color_by_number_BG_4
        set get_color_by_number_retv=%BG_COLOR_4%
        goto :eof
        :label_get_color_by_number_BG_5
        set get_color_by_number_retv=%BG_COLOR_5%
        goto :eof
        :label_get_color_by_number_BG_6
        set get_color_by_number_retv=%BG_COLOR_6%
        goto :eof
        :label_get_color_by_number_BG_7
        set get_color_by_number_retv=%BG_COLOR_7%
        goto :eof
        :label_get_color_by_number_BG_8
        set get_color_by_number_retv=%BG_COLOR_8%
        goto :eof
        :label_get_color_by_number_BG_9
        set get_color_by_number_retv=%BG_COLOR_9%
        goto :eof
        :label_get_color_by_number_BG_a
        :label_get_color_by_number_BG_10
        set get_color_by_number_retv=%BG_COLOR_10%
        goto :eof
        :label_get_color_by_number_BG_b
        :label_get_color_by_number_BG_11
        set get_color_by_number_retv=%BG_COLOR_11%
        goto :eof
        :label_get_color_by_number_BG_c
        :label_get_color_by_number_BG_12
        set get_color_by_number_retv=%BG_COLOR_12%
        goto :eof
        :label_get_color_by_number_BG_d
        :label_get_color_by_number_BG_13
        set get_color_by_number_retv=%BG_COLOR_13%
        goto :eof
        :label_get_color_by_number_BG_e
        :label_get_color_by_number_BG_14
        set get_color_by_number_retv=%BG_COLOR_14%
        goto :eof
        :label_get_color_by_number_BG_f 
        :label_get_color_by_number_BG_15
        set get_color_by_number_retv=%BG_COLOR_15%
        goto :eof
    )
goto :eof

