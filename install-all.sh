#!/usr/bin/env bash

print_green() {
    BOLD_GREEN=$(export BOLD_GREEN='\e[1;32m')
    NORMAL=$(export NORMAL='\e[m')
    echo "${BOLD_GREEN}$1${NORMAL}"
}

print_yellow() {
    BOLD_YELLOW=$(export BOLD_YELLOW='\e[1;33m')
    NORMAL=$(export NORMAL='\e[m')
    echo "${BOLD_YELLOW}$1${NORMAL}"
}

print_red() {
    BOLD_RED=$(export BOLD_RED='\e[1;31m')
    NORMAL=$(export NORMAL='\e[m')
    echo "${BOLD_RED}$1${NORMAL}"
}

print_blue() {
    BOLD_BLUE=$(export BOLD_BLUE='\e[1;34m')
    NORMAL=$(export NORMAL='\e[m')
    echo "${BOLD_BLUE}$1${NORMAL}"
}

print_delimiter() {
    echo
    echo "-------------------------------------------------------------------------------"
    echo

}

echo
echo
echo -e "=============================="
echo -e " Jok3r - Installation Script  "
echo -e "=============================="
echo
echo

# Make sure we are root !
if [ "$EUID" -ne 0 ]; then 
    echo -e "[!] Must be run as root"
    exit 1
fi

# -----------------------------------------------------------------------------

echo -e "[~] Running dependencies install script..."
bash install-dependencies.sh
if [ $? -eq 0 ]; then
    echo -e "[+] Dependencies install script exited with success returncode"
else
    echo -e "[!] Dependencies install script exited with error returncode"
    exit 1
fi
print_delimiter

# -----------------------------------------------------------------------------

echo -e "[~] Running Jok3r full toolbox install (in non-interactive mode)..."
python3 jok3r.py toolbox --install-all --auto
if [ $? -eq 0 ]; then
    echo -e "[+] Jok3r toolbox install exited with success returncode"
else
    echo -e "[!] Jok3r toolbox install exited with error returncode"
    exit 1
fi
print_delimiter

# -----------------------------------------------------------------------------

echo -e "[~] Running automatic check of all installed tools (based on returncodes)..."
python3 jok3r.py toolbox --check
if [ $? -eq 0 ]; then
    echo -e "[+] Toolbox automatic check exited with success returncode"
else
    echo -e "[!] Toolbox automatic check exited with error returncode"
    exit 1
fi
print_delimiter

# -----------------------------------------------------------------------------

echo -e "[~] Print toolbox content"
python3 jok3r.py toolbox --show-all

# -----------------------------------------------------------------------------

echo -e "[+] Install script finished with success"