#!/bin/bash

# NandaXploit - Pemantau Gempa Terakhir per Wilayah
# Author: NandaAnomiyos
# GitHub: github.com/Nandaanomiyos

# Warna
MERAH='\033[1;31m'
HIJAU='\033[1;32m'
KUNING='\033[1;33m'
BIRU='\033[1;34m'
UNGU='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

# Daftar wilayah dengan gempa terkini
declare -A daftar_wilayah=(
    [1]="Aceh"
    [2]="Sumatera"
    [3]="Jawa"
    [4]="Bali"
    [5]="Nusa Tenggara"
    [6]="Kalimantan" 
    [7]="Sulawesi"
    [8]="Maluku"
    [9]="Papua"
    [0]="Semua Wilayah"
)

tampilkan_header() {
    clear
    echo -e "${MERAH}"
    echo "   ____ _____ ___  ____ ___  "
    echo "  / ___| ____/ _ \|  _ \_ _| "
    echo " | |  _|  _|| | | | |_) | |  "
    echo " | |_| | |__| |_| |  __/| |  "
    echo "  \____|_____\___/|_|  |___| "
    echo -e "${NC}"
    echo -e "${BIRU}=========================================${NC}"
    echo -e "${KUNING}  GEMPA TERAKHIR PER WILAYAH nanXopilot  ${NC}"
    echo -e "${BIRU}=========================================${NC}"
    echo ""
}

pilih_wilayah() {
    echo -e "${CYAN}🌏 DAFTAR WILAYAH YANG TERSEDIA:${NC}"
    echo ""
    for nomor in "${!daftar_wilayah[@]}"; do
        echo -e "${KUNING} $nomor. ${daftar_wilayah[$nomor]}${NC}"
    done
    echo ""
    
    while true; do
        read -p "➤ Pilih nomor wilayah (0-9): " pilihan
        if [[ -v daftar_wilayah[$pilihan] ]]; then
            wilayah_terpilih="${daftar_wilayah[$pilihan]}"
            break
        else
            echo -e "${MERAH}❌ Pilihan tidak valid! Harap masukkan angka 0-9${NC}"
        fi
    done
}

ambil_gempa_terakhir() {
    wilayah="$1"
    
    # Ambil data dengan timeout 10 detik
    data=$(curl -s --max-time 10 "https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json")
    
    # Cek jika data kosong atau error
    if [[ -z "$data" ]]; then
        echo -e "${MERAH}❌ Gagal mengambil data dari BMKG${NC}"
        echo -e "${KUNING}🔧 Mencoba sumber backup...${NC}"
        data=$(curl -s --max-time 10 "https://cuaca-gempa-rest-api.vercel.app/quake")
    fi
    
    if [[ "$wilayah" == "Semua Wilayah" ]]; then
        # Ambil gempa terbaru di Indonesia
        echo "$data" | jq -r '.Infogempa.gempa[] | select(.Magnitude != "" and (.Magnitude | tonumber > 0))' | 
        jq -s 'sort_by(.Jam + .Tanggal) | reverse | .[0]'
    else
        # Filter berdasarkan wilayah pilihan
        echo "$data" | jq -r --arg wil "$wilayah" '.Infogempa.gempa[] | select(.Wilayah | contains($wil) and (.Magnitude | tonumber > 0))' |
        jq -s 'sort_by(.Jam + .Tanggal) | reverse | .[0]'
    fi
}

tampilkan_hasil() {
    gempa="$1"
    wilayah="$2"
    
    tampilkan_header
    echo -e "${HIJAU}📍 WILAYAH: ${UNGU}$wilayah${NC}"
    echo -e "${BIRU}=========================================${NC}"
    echo ""
    
    if [[ -z "$gempa" || "$gempa" == "null" ]]; then
        echo -e "${KUNING}⚠ Tidak ada aktivitas gempa tercatat dalam 24 jam terakhir${NC}"
        echo -e "${CYAN}Terakhir diperiksa: $(date '+%d-%m-%Y %H:%M:%S')${NC}"
    else
        echo "$gempa" | jq -r '
        "📅 " + .Tanggal + " " + .Jam + 
        "\n🌍 " + .Wilayah + 
        "\n💥 " + .Magnitude + " SR | Kedalaman: " + .Kedalaman + 
        "\n📍 " + .Coordinates + 
        "\n🚨 " + .Potensi'
        echo -e "${CYAN}Terakhir diperbarui: $(date '+%d-%m-%Y %H:%M:%S')${NC}"
    fi
    
    echo ""
    echo -e "${BIRU}=========================================${NC}"
    echo -e "${KUNING}Tekan Enter untuk kembali memilih wilayah${NC}"
    read -p ""
}

# Main program
if ! command -v jq &> /dev/null; then
    echo -e "${MERAH}❌ Package jq belum terinstall${NC}"
    echo -e "${KUNING}Menginstall jq...${NC}"
    pkg install jq -y && clear
fi

while true; do
    tampilkan_header
    pilih_wilayah
    hasil=$(ambil_gempa_terakhir "$wilayah_terpilih")
    tampilkan_hasil "$hasil" "$wilayah_terpilih"
done
