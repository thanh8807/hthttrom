#!/bin/bash

# === CÀI ĐẶT SERVER GAME TRÊN TERMUX ===
# ✅ Không chiếm quyền Termux
# ✅ Cài đặt an toàn, dễ kiểm soát
# ✅ Chỉ bạn mới dùng được bằng key riêng

# Key riêng của bạn
PRIVATE_KEY="htht1234"

clear
echo "\n  (Server Game Termux - Phiên bản tùy chỉnh)\n"
echo "  Chỉ bạn có thể cài đặt bằng key riêng."
echo "  Nếu muốn tiếp tục, hãy nhập key của bạn.\n"

read -p "Nhập Key: " user_key

# Kiểm tra key
if [[ "$user_key" != "$PRIVATE_KEY" ]]; then
    echo "\n❌ Key không hợp lệ! Thoát..."
    exit 1
fi

echo "\n✅ Key hợp lệ! Tiến hành cài đặt...\n"

echo "\n🔄 Đang cập nhật Termux..."
pkg update -y && pkg upgrade -y

# Kiểm tra kiến trúc CPU để tải file phù hợp
cpu_arch=$(dpkg --print-architecture)
case $cpu_arch in
    aarch64) arch="aarch64" ;;
    arm) arch="arm" ;;
    x86_64) arch="x64" ;;
    *) echo "❌ Không hỗ trợ kiến trúc này!"; exit 1 ;;
esac

# URL tải server game (bạn có thể thay đổi thành server của bạn)
GAME_SERVER_URL="https://example.com/game-server-${arch}.deb"
INSTALL_SCRIPT_URL="https://example.com/install.sh"

echo "\n📥 Đang tải game server..."
curl -L --progress-bar "$GAME_SERVER_URL" -o game-server.deb || { echo "❌ Lỗi tải file!"; exit 1; }

echo "\n🔧 Đang cài đặt game server..."
dpkg -i game-server.deb || { echo "❌ Lỗi khi cài đặt!"; exit 1; }

# Tải script cài đặt bổ sung
curl -L --progress-bar "$INSTALL_SCRIPT_URL" -o install.sh || { echo "❌ Lỗi tải script!"; exit 1; }
chmod +x install.sh

# Chạy script cài đặt
./install.sh

echo "\n🎉 Cài đặt hoàn tất! Bạn có thể bắt đầu chơi game ngay bây giờ.\n"
