#!/bin/bash

# Membuat folder dxs
mkdir dxs

# Masuk ke dalam folder dxs
cd dxs

# Mendownload file dari URL yang diberikan
wget https://github.com/Bendr0id/xmrigCC/releases/download/3.3.3/xmrigCC-miner_only-3.3.3-linux-generic-static-amd64.tar.gz

# Mengekstrak file yang diunduh
tar -xvf xmrigCC-miner_only-3.3.3-linux-generic-static-amd64.tar.gz

# Menyimpan ID proses xmrigDaemon
xmrig_pid=""

# Fungsi untuk menjalankan xmrigDaemon dengan opsi -p yang acak
start_xmrig() {
    while true; do
        # Membuat nama acak untuk opsi -p
        random_p=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6)
        
        # Mendapatkan jumlah core CPU
        num_cores=$(nproc)
        
        # Menjalankan xmrigDaemon dengan opsi yang diinginkan
        ./xmrigDaemon -o zephyr.miningocean.org:5332 -u ZEPHYR3Zsd7VS27u64VPw8dRax5JtgYbL6KSbfK8QLdWdQZRwN7WtdTCa5jCTucisNXdNH6KRCgmaU49oQXd4HCfDTUgR39KR5k36 -p "zeus${random_p}${num_cores}core" -a rx/0 -k --donate-level 1
        
        # Menyimpan ID proses xmrigDaemon
        xmrig_pid=$!

        # Menunggu selama 5 detik sebelum mencoba menjalankan ulang
        sleep 5
    done
}

# Fungsi untuk menghentikan xmrigDaemon
stop_xmrig() {
    if [ -n "$xmrig_pid" ]; then
        # Menghentikan xmrigDaemon
        kill -9 "$xmrig_pid"
        xmrig_pid=""
    fi
}

# Menangani sinyal SIGINT (Ctrl+C)
trap stop_xmrig INT

# Memanggil fungsi untuk memulai xmrigDaemon
start_xmrig
