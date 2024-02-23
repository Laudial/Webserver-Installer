#!/bin/bash

# Déclaration des variables
local_ip_address=$(hostname -I | awk '{print $1}' | grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$')

# Définition des codes ANSI pour les couleurs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

function Message() {
    local message="$1"
    local cols=$(tput cols)  # Longueur de la ligne du terminal
    local message_length=${#message}
    local padding=$(( (cols - message_length) / 2 ))

    # Ajout de la couleur et de l'alignement
    echo -e "\n${BLUE}$(printf "%${padding}s")$message$(printf "%${padding}s")${NC}"
}

# Nettoyage du terminal
clear

# Vérifcation des permissions
if [ "$EUID" -ne 0 ]
  then
  Message "$RED Veuillez lancer le script en root $NC"
  exit
else
  Message "$GREEN Lancement du script $NC"
fi

# Mise à jour des paquets
Message "$BLUE Mise à jour des paquets $NC"
apt update
sleep 2;

# Installation d'Apache2
Message "$BLUE Installation d'Apache2 $NC"
apt install -y apache2

echo -e "$local_ip_address"
# ... (reste du script)