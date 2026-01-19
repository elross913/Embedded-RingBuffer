# Définition de la configuration de l'host pour le build

# Image de base légère et stable
FROM ubuntu:22.04

# Évite les questions interactives pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installation des outils nécessaires identifiés dans votre CI actuelle
# build-essential fournit g++, make, etc.
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cppcheck \
    clang-format \
    clang-tidy \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Par défaut, on lance un bash
CMD ["/bin/bash"]