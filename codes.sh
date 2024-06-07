#!/bin/bash

read -p "Enter the domain name to scan: " DOMAIN
mkdir -p results
echo "[*] Enumerating subdomains with assetfinder..."
assetfinder --subs-only $DOMAIN | tee results/assetfinder.txt

echo "[*] Enumerating subdomains with subfinder..."
subfinder -d $DOMAIN -silent | tee results/subfinder.txt

# Enumerate subdomains using sublist3r
echo "[*] Enumerating subdomains with sublist3r..."
sublist3r -d $DOMAIN -o results/sublist3r.txt

# Enumerate subdomains using amass
echo "[*] Enumerating subdomains with amass..."
amass enum -d $DOMAIN -o results/amass.txt

# Combine all subdomain results into a single file
echo "[*] Combining all subdomain results..."
cat results/*.txt | sort -u | tee results/all_subdomains.txt
