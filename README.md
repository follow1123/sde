# Suckless Desktop Environment(Suckless桌面环境)

## 依赖

```bash
apt install libx11-dev libxft-dev libxinerama-dev xorg make gcc libgtk-3-dev libgcr-3-dev libwebkit2gtk-4.0-dev -y
```

## dwm

> [官网](https://dwm.suckless.org/)

```bash
# 编译安装
cd ~/sde/dwm
sudo make clean install
```
## st 

> [官网](https://st.suckless.org/)

```bash
# 编译安装
cd ~/sde/st
sudo make clean install
```

## dwmblocks-async

> [github](https://github.com/UtkarshVerma/dwmblocks-async)

```bash
# 编译安装
cd ~/sde/dwmblocks-async
sudo make clean install
```

## dunst

> 通知服务

```bash
# 安装依赖
sudo apt install libnotify-dev libxss-dev libnotify-bin -y

# 安装
cd ~/space/soft
git clone https://github.com/dunst-project/dunst.git
cd dunst
# 是否启用wayland
make WAYLAND=0
sudo make install

# 配置
ln -s ~/sde/dunst ~/.config
```

## fcitx5

> 输入法

```bash
# 安装
sudo apt install fcitx5 fcitx5-chinese-addons im-config -y

# 配置
ln -s ~/sde/fcitx5 ~/.config
```

## rofi

> 应用启动器 [github](https://github.com/davatorium/rofi)

```bash
# 依赖
sudo apt install papirus-icon-theme autotools-dev autoconf automake libtool -y
sudo apt install libxcb1-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev libxcb-randr0-dev libxcb-xinerama0-dev libxcb-util-dev libstartup-notification0-dev check -y

# 安装

cd ~/space/soft
git clone https://github.com/davatorium/rofi.git -b 1.7.4
cd rofi
git submodule update --init
autoreconf -i
mkdir -p build && cd build
~/space/soft/rofi/configure
make && sudo make install

# 配置
ln -s ~/sde/rofi/files ~/.config/rofi
```

## picom

> 窗口渲染器

```bash
# 安装
sudo apt install picom -y

# 配置
ln -s ~/sde/picom/picom.conf ~/.config/picom.conf
```

## 其他软件

* trayer (系统托盘)
* nemo (文件管理器)
* feh (壁纸)
* playerctl (媒体工具)
* polkit-kde-agent-1 (认证弹框)
* light (屏幕亮度)

```bash
sudo apt install trayer feh nemo playerctl polkit-kde-agent-1 light -y
```

## x桌面配置

```bash
ln -s ~/sde/x/xinitrc ~/.xinitrc
```

## 字体

```bash
# 安装中文字体
sudo apt install fonts-wqy-microhei -y

# 下载字体压缩包
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
wget -P ~/Downloads https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip

# 解压
sudo unzip ~/Downloads/FiraMono -d /usr/share/fonts/FiraMono
sudo unzip ~/Downloads/JetBrainsMono -d /usr/share/fonts/JetBrainsMono
sudo unzip ~/Downloads/NerdFontsSymbolsOnly -d /usr/share/fonts/NerdFontsSymbolsOnly
unzip ~/Downloads/JetBrainsMono-2.304.zip
sudo mv fonts/* /usr/share/fonts

# 刷新字体文件
cd /usr/share/fonts/
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
```

## 蓝牙

* 蓝牙协议依赖

```bash
sudo apt install alsa-utils bluez -y
```

### pulseaudio

```bash
# 依赖
sudo apt install pulseaudio pulseaudio-utils pulseaudio-module-bluetooth
```

### pipewire
> 新版蓝牙服务

```bash
# 依赖
sudo apt install pipewire pipewire-pulse pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack wireplumber

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

## Nvidia显卡驱动

* 在[官网](https://www.nvidia.cn/Download/index.aspx?lang=cn)下载驱动文件

```bash
# 安装依赖
sudo apt install build-essential libglvnd-dev linux-source linux-headers-$(uname -r) -y
# 禁用nouveau驱动
echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/blacklist.conf

# 安装驱动
# 如果提示X server相关则加上 -no-x-check参数
# 卸载，加上--uninstall 参数
sudo bash 驱动文件 -no-x-check
