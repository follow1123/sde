# suckless 相关软件组成的桌面环境配置

## 安装依赖
* `apt install libx11-dev libxft-dev libxinerama-dev xorg make gcc`
* 下载子模块：`git submodule update --init`
## 安装桌面环境相关工具
* picom (窗口渲染器)
* rofi (程序启动器)
* libnotify-bin (用于发送通知notify-send)
* trayer (系统托盘)
* nemo (文件管理器)
* feh (壁纸)
* fcitx (输入法)
* fonts-wqy-microhei (中文字体)
* playerctl (媒体工具)
```bash
sudo apt install dunst picom rofi libnotify-bin trayer feh nemo fcitx fcitx-pinyin fonts-wqy-microhei alsa-utils pulseaudio-utils playerctl
```
* 蓝牙相关
    ```bash
    sudo apt install alsa-utils bluez pipewire pipewire-pulse

    # 禁用pulseaudio
    systemctl --user stop pulseaudio.socket
    systemctl --user stop pulseaudio.service
    systemctl --user disable pulseaudio.socket
    systemctl --user disable pulseaudio.service
    systemctl --user mask pulseaudio

    # 启用 pipewire
    systemctl --user enable pipewire
    systemctl --user start pipewire
    systemctl --user enable pipewire-pulse
    systemctl --user start pipewire-pulse

    # 重启
    ```
## 安装nerdfont字体
```bash
# 下载字体压缩包
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
# 解压
sudo unzip FiraMono -d /usr/share/fonts/FiraMono
sudo unzip JetBrainsMono -d /usr/share/fonts/JetBrainsMono
sudo unzip NerdFontsSymbolsOnly -d /usr/share/fonts/NerdFontsSymbolsOnly
unzip JetBrainsMono-2.304.zip
sudo mv fonts/* /usr/share/fonts
cd /usr/share/fonts/
# 刷新字体文件
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
```
## 安装suckless系列软件
* 依次进入 dwm、dwmblocks-async、st文件夹执行：`sudo make clean install`
## 关联配置文件
```bash
ln -s ~/sde/dunst ~/.config/
ln -s ~/sde/x/xinitrc ~/.xinitrc
```

## nvidia显卡驱动
* 依赖：`sudo apt update && sudo apt install build-essential libglvnd-dev`
* 修改文件：`sudo vim /etc/modprobe.d/blacklist.conf`
    * 文件内添加：`blacklist nouveau`
* 安装命令：sudo bash 文件名
    * 如果提示X server相关则加上 -no-x-check参数
    * 卸载，加上--uninstall 参数
* 如果出现以下错误
```
Unable to find the kernel source tree for the currently running kernel.  Please make sure you have installed the kernel source files for
your kernel and that they are properly configured; on Red Hat Linux systems, for example, be sure you have the 'kernel-source' or
'kernel-devel' RPM installed.  If you know the correct kernel source files are installed, you may specify the kernel source path with
the '--kernel-source-path' command line option
```
* 则执行以下命令，(debian)
    * 安装内核源码包：`sudo apt install linux-source`
    * 安装内核头文件包：`sudo apt install linux-headers-$(uname -r)`

