# Nom de l'image pour l'usine logicielle
IMAGE_NAME = embedded-factory
# Dossier de build interne à Docker
BUILD_DIR = build_docker

.PHONY: all build_image test clean

# Par défaut : construit l'image et lance les tests
all: build_image test

# Étape de construction de l'environnement (Image Docker)
build_image:
	docker build -t $(IMAGE_NAME) .

# Étape d'exécution du cycle complet dans Docker
# On monte le répertoire courant dans /app du conteneur
test:
	docker run --rm -v $(shell pwd):/app $(IMAGE_NAME) bash -c "\
		cppcheck --enable=all --inline-suppr --language=c++ --std=c++17 --error-exitcode=1 -I include/ . && \
		cmake -B $(BUILD_DIR) -S . && \
		cmake --build $(BUILD_DIR) && \
		cd $(BUILD_DIR) && ctest --output-on-failure"

# Nettoyage des dossiers de compilation
clean:
	rm -rf $(BUILD_DIR) build/