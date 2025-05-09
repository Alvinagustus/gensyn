#!/bin/bash

BOLD="\e[1m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

SWARM_DIR="$HOME/rl-swarm-test"
TEMP_DATA_PATH="$SWARM_DIR/modal-login/temp-data"
HOME_DIR="$HOME"

cd $HOME

if [ -f "$SWARM_DIR/swarm.pem" ]; then
    echo -e "${BOLD}${YELLOW}You already have an existing ${GREEN}swarm.pem${YELLOW} file.${NC}\n"
    echo -e "${BOLD}${YELLOW}Do you want to:${NC}"
    echo -e "${BOLD}1) Use the existing swarm.pem${NC}"
    echo -e "${BOLD}${RED}2) Delete existing swarm.pem and start fresh${NC}"

    while true; do
        read -p $'\e[1mEnter your choice (1 or 2): \e[0m' choice
        if [ "$choice" == "1" ]; then
            echo -e "\n${BOLD}${YELLOW}[✓] Using existing swarm.pem...${NC}"
            mv "$SWARM_DIR/swarm.pem" "$HOME_DIR/"
            mv "$TEMP_DATA_PATH/userData.json" "$HOME_DIR/" 2>/dev/null
            mv "$TEMP_DATA_PATH/userApiKey.json" "$HOME_DIR/" 2>/dev/null

            rm -rf "$SWARM_DIR"

            echo -e "${BOLD}${YELLOW}[✓] Cloning fresh repository...${NC}"
            cd $HOME && git clone https://github.com/Alvinagustus/rl-swarm-test.git > /dev/null 2>&1

            mv "$HOME_DIR/swarm.pem" rl-swarm-test/
            mv "$HOME_DIR/userData.json" rl-swarm-test/modal-login/temp-data/ 2>/dev/null
            mv "$HOME_DIR/userApiKey.json" rl-swarm-test/modal-login/temp-data/ 2>/dev/null
            break
        elif [ "$choice" == "2" ]; then
            echo -e "${BOLD}${YELLOW}[✓] Removing existing folder and starting fresh...${NC}"
            rm -rf "$SWARM_DIR"
            cd $HOME && git clone https://github.com/Alvinagustus/rl-swarm-test.git > /dev/null 2>&1
            break
        else
            echo -e "\n${BOLD}${RED}[✗] Invalid choice. Please enter 1 or 2.${NC}"
        fi
    done
else
    echo -e "${BOLD}${YELLOW}[✓] No existing swarm.pem found. Cloning repository...${NC}"
    cd $HOME && [ -d rl-swarm-test ] && rm -rf rl-swarm-test; git clone https://github.com/Alvinagustus/rl-swarm-test.git > /dev/null 2>&1
fi

cd rl-swarm-test || { echo -e "${BOLD}${RED}[✗] Failed to enter rl-swarm-reward directory. Exiting.${NC}"; exit 1; }

if [ -n "$VIRTUAL_ENV" ]; then
    echo -e "${BOLD}${YELLOW}[✓] Deactivating existing virtual environment...${NC}"
    deactivate
fi

echo -e "${BOLD}${YELLOW}[✓] Setting up Python virtual environment...${NC}"
chmod +x ./run_rl_swarm_ngrok.sh

echo -e "${BOLD}${YELLOW}[?] Mau jalanin dengan apa? Kalo udah ada swarm.pem dan loginnya dan cuma mau update ketik 1 (1: cloudflared, 2: ngrok)${NC}"
read -p "Pilih (1/2): " pilihan

if [[ "$pilihan" == "1" ]]; then
    echo -e "${BOLD}${YELLOW}[✓] Menjalankan dengan cloudflared...${NC}"
    if [ ! -d ".venv" ]; then
        echo -e "${BOLD}${YELLOW}[✓] Buat .venv dulu ya gaes ya${NC}"
        python3 -m venv .venv
    fi
    source .venv/bin/activate
    echo -e "${BOLD}${YELLOW}[✓] Running RL-SWARM${NC}"
    ./run_rl_swarm.sh
elif [[ "$pilihan" == "2" ]]; then
    echo -e "${BOLD}${YELLOW}[✓] Menjalankan dengan ngrok...${NC}"
    if [ ! -d ".venv" ]; then
        echo -e "${BOLD}${YELLOW}[✓] Buat .venv dulu ya gaes ya${NC}"
        python3 -m venv .venv
    fi
    source .venv/bin/activate
    echo -e "${BOLD}${YELLOW}[✓] Running RL-SWARM${NC}"
    ./run_rl_swarm_ngrok.sh
else
    echo -e "${BOLD}${RED}[!] Pilihan tidak valid. Keluar.${NC}"
    exit 1
fi
