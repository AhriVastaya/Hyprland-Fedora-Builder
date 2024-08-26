sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo # Unneeded Repo
dnf upgrade -y
sudo dnf install git -y # Needed for cloning of the Hyprland repos

sudo dnf install -y gcc-c++ \
                    g++ \
                    meson \
                    cmake \
                    "pkgconfig(cairo)" \
                    "pkgconfig(egl)" \
                    "pkgconfig(gbm)" \
                    "pkgconfig(gl)" \
                    "pkgconfig(glesv2)" \
                    "pkgconfig(libdrm)" \
                    "pkgconfig(libinput)" \
                    "pkgconfig(libseat)" \
                    "pkgconfig(libudev)" \
                    "pkgconfig(pango)" \
                    "pkgconfig(pangocairo)" \
                    "pkgconfig(pixman-1)" \
                    "pkgconfig(vulkan)" \
                    "pkgconfig(wayland-client)" \
                    "pkgconfig(wayland-server)" \
                    "pkgconfig(wayland-protocols)" \
                    "pkgconfig(wayland-scanner)" \
                    "pkgconfig(xcb)" \
                    "pkgconfig(xcb-icccm)" \
                    "pkgconfig(xcb-renderutil)" \
                    "pkgconfig(xkbcommon)" \
                    "pkgconfig(xwayland)" \
                    "pkgconfig(xcb-errors)" \
                    "pkgconfig(glslang)" \
                    "pkgconfig(tomlplusplus)" \
                    "pkgconfig(pugixml)" \
                    "pkgconfig(libzip)" \
                    "pkgconfig(librsvg-2.0)" \
                    "pkgconfig(uuid)" \
                    "pkgconfig(xcursor)" \
                    "pkgconfig(libliftoff)" \
                    "pkgconfig(xcb-util)" \
                    "pkgconfig(libdisplay-info)" \
                    "pkgconfig(hwdata)"

mkdir /old-usr
cp /usr/* -R /old-usr

git clone https://github.com/hyprwm/hyprwayland-scanner /Source/hyprwayland-scanner
cd /Source/hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
cmake --install build
cd /Source

git clone https://github.com/hyprwm/hyprutils /Source/hyprutils
cd /Source/hyprutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /Source

git clone https://github.com/hyprwm/aquamarine /Source/aquamarine
cd /Source/aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /Source

git clone https://github.com/hyprwm/hyprlang /Source/hyprlang
cd /Source/hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target hyprlang
cmake --install build
cd /Source

git clone https://github.com/hyprwm/hyprcursor /Source/hyprcursor
cd /Source/hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /Source

git clone https://github.com/hyprwm/Hyprland --recursive /Source/Hyprland
cd /Source/Hyprland
export CXXFLAGS=-std=gnu++26
export CXX=/usr/bin/g++
export CC=/usr/bin/gcc
make all
make install
cd /Source

echo "

"
diff --recursive --brief /old-usr /usr 2> /dev/null | grep "Only in"
mkdir -p /Build/usr/{bin,include,lib64,local}
mkdir -p /Build/usr/lib64/pkgconfig
mkdir -p /Build/usr/local/share/
mkdir -p /Build/usr/local/share/man/man1
mkdir -p /Build/usr/local/share
mkdir -p /Build/usr/lib64/cmake
mkdir -p /Build/usr/local/bin/
mkdir -p /Build/usr/local/include
echo "

"
cp /usr/bin/hyprcursor-util /Build/usr/bin/hyprcursor-util
cp /usr/bin/hyprwayland-scanner /Build/usr/bin/hyprwayland-scanner
cp -r /usr/include/aquamarine /Build/usr/include/aquamarine
cp -r /usr/include/hyprcursor /Build/usr/include/hyprcursor
cp /usr/include/hyprcursor.hpp /Build/usr/include/hyprcursor.hpp
cp /usr/include/hyprlang.hpp /Build/usr/include/hyprlang.hpp
cp -r /usr/include/hyprutils /Build/usr/include/hyprutils
cp -r /usr/lib64/cmake/hyprwayland-scanner /Build/usr/lib64/cmake/hyprwayland-scanner
cp /usr/lib64/libaquamarine.so /Build/usr/lib64/libaquamarine.so
cp /usr/lib64/libaquamarine.so.0.3.3 /Build/usr/lib64/libaquamarine.so.0.3.3
cp /usr/lib64/libaquamarine.so.2 /Build/usr/lib64/libaquamarine.so.2
cp /usr/lib64/libhyprcursor.so /Build/usr/lib64/libhyprcursor.so
cp /usr/lib64/libhyprcursor.so.0 /Build/usr/lib64/libhyprcursor.so.0
cp /usr/lib64/libhyprcursor.so.0.1.9 /Build/usr/lib64/libhyprcursor.so.0.1.9
cp /usr/lib64/libhyprlang.so /Build/usr/lib64/libhyprlang.so
cp /usr/lib64/libhyprlang.so.0.5.2 /Build/usr/lib64/libhyprlang.so.0.5.2
cp /usr/lib64/libhyprlang.so.2 /Build/usr/lib64/libhyprlang.so.2
cp /usr/lib64/libhyprutils.so /Build/usr/lib64/libhyprutils.so
cp /usr/lib64/libhyprutils.so.0.2.1 /Build/usr/lib64/libhyprutils.so.0.2.1
cp /usr/lib64/libhyprutils.so.1 /Build/usr/lib64/libhyprutils.so.1
cp /usr/lib64/pkgconfig/aquamarine.pc           /Build/usr/lib64/pkgconfig/aquamarine.pc         
cp /usr/lib64/pkgconfig/hyprcursor.pc           /Build/usr/lib64/pkgconfig/hyprcursor.pc         
cp /usr/lib64/pkgconfig/hyprlang.pc             /Build/usr/lib64/pkgconfig/hyprlang.pc           
cp /usr/lib64/pkgconfig/hyprutils.pc            /Build/usr/lib64/pkgconfig/hyprutils.pc          
cp /usr/lib64/pkgconfig/hyprwayland-scanner.pc  /Build/usr/lib64/pkgconfig/hyprwayland-scanner.pc
cp -r /usr/local/bin/Hyprland  /Build/usr/local/bin/Hyprland  
cp -r /usr/local/bin/hyprctl   /Build/usr/local/bin/hyprctl   
cp -r /usr/local/bin/hyprland  /Build/usr/local/bin/hyprland  
cp -r /usr/local/bin/hyprpm    /Build/usr/local/bin/hyprpm    
cp -r /usr/local/include/hyprland /Build/usr/local/include/hyprland
cp -r /usr/local/share/bash-completion /Build/usr/local/share/bash-completion
cp -r /usr/local/share/fish            /Build/usr/local/share/fish           
cp -r /usr/local/share/hypr            /Build/usr/local/share/hypr           
cp /usr/local/share/man/man1/Hyprland.1 /Build/usr/local/share/man/man1/Hyprland.1
cp /usr/local/share/man/man1/hyprctl.1  /Build/usr/local/share/man/man1/hyprctl.1 
cp -r /usr/local/share/pkgconfig           /Build/usr/local/share/pkgconfig          
cp -r /usr/local/share/wayland-sessions    /Build/usr/local/share/wayland-sessions   
cp -r /usr/local/share/xdg-desktop-portal  /Build/usr/local/share/xdg-desktop-portal 
cp -r /usr/local/share/zsh                 /Build/usr/local/share/zsh                