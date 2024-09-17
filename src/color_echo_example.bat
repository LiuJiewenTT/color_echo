@REM set screen_color=0f
call color_echo_main.bat re-init
@echo 当前echo应当处于关闭模式 
echo.
echo 这是当前颜色的文本 
echo.

echo 接下来是前景背景展示并尾随读取的重置值的示例变化： 
echo %FG_BLACK%这是黑色的文本%FG_RESET%%BG_BLACK%这是黑色的背景%BG_RESET%
echo %FG_RED%这是红色的文本%CE_RESET%%BG_RED%这是红色的背景%BG_RESET%
echo %FG_GREEN%这是绿色的文本%CE_RESET%%BG_GREEN%这是绿色的背景%BG_RESET%
echo %FG_YELLOW%这是黄色的文本%CE_RESET%%BG_YELLOW%这是黄色的背景%BG_RESET%
echo %FG_BLUE%这是蓝色的文本%FG_RESET%%BG_BLUE%这是蓝色的背景%BG_RESET%
echo %FG_MAGENTA%这是紫色的文本%FG_RESET%%BG_MAGENTA%这是紫色的背景%BG_RESET%
echo %FG_CYAN%这是青色的文本%FG_RESET%%BG_CYAN%这是青色的背景%BG_RESET%
echo %FG_WHITE%这是白色的文本%FG_RESET%%BG_WHITE%这是白色的背景%BG_RESET%
echo %FG_BRIGHT_BLACK%这是亮黑色的文本%FG_RESET%%BG_BRIGHT_BLACK%这是亮黑色的背景%BG_RESET%
echo %FG_BRIGHT_RED%这是亮红色的文本%FG_RESET%%BG_BRIGHT_RED%这是亮红色的背景%BG_RESET%
echo %FG_BRIGHT_GREEN%这是亮绿色的文本%FG_RESET%%BG_BRIGHT_GREEN%这是亮绿色的背景%BG_RESET%
echo %FG_BRIGHT_YELLOW%这是亮黄色的文本%FG_RESET%%BG_BRIGHT_YELLOW%这是亮黄色的背景%BG_RESET%
echo %FG_BRIGHT_BLUE%这是亮蓝色的文本%FG_RESET%%BG_BRIGHT_BLUE%这是亮蓝色的背景%BG_RESET%
echo %FG_BRIGHT_MAGENTA%这是亮紫色的文本%FG_RESET%%BG_BRIGHT_MAGENTA%这是亮紫色的背景%BG_RESET%
echo %FG_BRIGHT_CYAN%这是亮青色的文本%FG_RESET%%BG_BRIGHT_CYAN%这是亮青色的背景%BG_RESET%
echo %FG_BRIGHT_WHITE%这是亮白色的文本%FG_RESET%%BG_BRIGHT_WHITE%这是亮白色的背景%BG_RESET%
echo %CE_RESET%完全重置完成
echo.

echo 接下来是各色变化并尾随完全重置的版本： 
echo %FG_BLACK%这是黑色的文本%CE_RESET%
echo %FG_RED%这是红色的文本%CE_RESET%
echo %FG_GREEN%这是绿色的文本%CE_RESET%
echo %FG_YELLOW%这是黄色的文本%CE_RESET%
echo %FG_BLUE%这是蓝色的文本%CE_RESET%
echo %FG_MAGENTA%这是紫色的文本%CE_RESET%
echo %FG_CYAN%这是青色的文本%CE_RESET%
echo %FG_WHITE%这是白色的文本%CE_RESET%
echo %FG_BRIGHT_BLACK%这是亮黑色的文本%CE_RESET%
echo %FG_BRIGHT_RED%这是亮红色的文本%CE_RESET%
echo %FG_BRIGHT_GREEN%这是亮绿色的文本%CE_RESET%
echo %FG_BRIGHT_YELLOW%这是亮黄色的文本%CE_RESET%
echo %FG_BRIGHT_BLUE%这是亮蓝色的文本%CE_RESET%
echo %FG_BRIGHT_MAGENTA%这是亮紫色的文本%CE_RESET%
echo %FG_BRIGHT_CYAN%这是亮青色的文本%CE_RESET%
echo %FG_BRIGHT_WHITE%这是亮白色的文本%CE_RESET%
echo 这是默认颜色的文本
