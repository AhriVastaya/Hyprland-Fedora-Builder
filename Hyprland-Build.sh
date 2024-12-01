sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo # Unneeded Repo
dnf upgrade -y
sudo dnf install git -y # Needed for cloning of the Hyprland repos

sudo dnf install -y gcc-c++ \
                    g++ \
                    meson \
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

git clone https://github.com/Kitware/CMake /tmp/CMake
cd /tmp/CMake
./bootstrap
make
make install

git clone https://github.com/hyprwm/hyprwayland-scanner /tmp/hyprwayland-scanner
cd /tmp/hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
cmake --install build
cd /tmp

git clone https://github.com/hyprwm/hyprutils /tmp/hyprutils
cd /tmp/hyprutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /tmp

git clone https://github.com/hyprwm/aquamarine /tmp/aquamarine
cd /tmp/aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /tmp

git clone https://github.com/hyprwm/hyprlang /tmp/hyprlang
cd /tmp/hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target hyprlang
cmake --install build
cd /tmp

git clone https://github.com/hyprwm/hyprcursor /tmp/hyprcursor
cd /tmp/hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B build
cmake --build ./build --config Release --target all
cmake --install build
cd /tmp

git clone https://github.com/hyprwm/Hyprland --recursive /tmp/Hyprland
cd /tmp/Hyprland
export CXXFLAGS=-std=gnu++26
export CXX=/usr/bin/g++
export CC=/usr/bin/gcc
make all
make install
cd /tmp
