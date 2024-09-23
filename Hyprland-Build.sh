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

rm /Source -fr
