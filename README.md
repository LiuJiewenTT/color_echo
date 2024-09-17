# color_echo

Color Echo library for Windows CMD.

这是一个为Windows CMD开发的彩色显示加载库。

## 介绍

使用这个程序加载后，就可以在输出时方便地切换色彩了。可用的色彩，见`color_echo_define.bat`中的定义。

通常来说，程序的主文件是`color_echo_main.bat`。但是如果您不需要自动配置单独的前景色重置或背景色重置，也不需要自动启用彩色支持，您也可以直接调用`color_echo_define.bat`，这样运行速度更快。

> 目前的`color_echo_main.bat`会尝试从注册表读取配置，这一步在部分电脑上可能有时会卡慢。

## 效果展示

## ![image-20240917195358160](README.assets/image-20240917195358160.png)

## 使用

查看示例和效果：

``` cmd
color_echo_example.bat
```

查看帮助：

``` cmd
color_echo_main.bat --help
```

您可以在调用前设置`screen_color`的值，可用值与使用`color`命令是一致的。`screen_color`的值会影响单独前景色重置和单独背景色重置的设置。