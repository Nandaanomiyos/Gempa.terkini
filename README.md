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

## INSTALASI NandaXploit Pemantau Gempa
```bash
pkg update && pkg upgrade
pkg install git curl jq -y
git clone https://github.com/Nandaanomiyos/Gempa.terkini.git
cd Gempa.terkini
bash gemp.sh
```

# CATATAN PENTING:
# - Pastikan koneksi internet stabil
# - Jika error "./gemp.sh not found", gunakan:
#   bash gempa.sh  (bukan ./gemp.sh)

