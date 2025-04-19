# 🌋 NandaXploit - Pemantau Gempa BMKG

[![GitHub license](https://img.shields.io/github/license/Nandaanomiyos/Gempa.terkini)](LICENSE)
[![Termux](https://img.shields.io/badge/Platform-Termux-brightgreen)](https://termux.com)
[![Last Commit](https://img.shields.io/github/last-commit/Nandaanomiyos/Gempa.terkini)](https://github.com/Nandaanomiyos/Gempa.terkini/commits/main)

![Preview Aplikasi](https://i.postimg.cc/mkFZB92j/Screenshot-20250419-104531.jpg)

Tools pemantau gempa Indonesia real-time berbasis CLI untuk Termux, mengambil data resmi dari **BMKG** (_Badan Meteorologi, Klimatologi, dan Geofisika_).

## 📋 Fitur Utama
- ✅ Data gempa **real-time** dari server BMKG
- 🔍 Pemantauan per wilayah (Aceh sampai Papua)
- 🎨 Tampilan **berwarna** dengan informasi lengkap:
  - 📅 Tanggal & waktu kejadian
  - 💥 Magnitude (Skala Richter)
  - ⬇ Kedalaman episentrum
  - 🧭 Koordinat lokasi
  - 🚨 Potensi dampak
- 🔄 Auto-update data
- 📱 Kompatibel dengan Termux (Android)

## 🛠️ Prasyarat
- Termux versi terbaru
- Koneksi internet
- Storage 50MB tersedia

## 📥 Instalasi
### Metode 1: Clone Repository
```bash
# Update package Termux
pkg update -y && pkg upgrade -y

# Install dependensi
pkg install -y git curl jq

# Clone repo
git clone https://github.com/Nandaanomiyos/Gempa.terkini.git

# Masuk direktori
cd Gempa.terkini

# Beri permission
chmod +x gempa.sh

# Jalankan aplikasi
./gempa.sh
