IMAGE_NAME = embedded-factory
BUILD_DIR = build_docker

.PHONY: all build_image test check-format clean

all: build_image check-format test

build_image:
	docker build -t $(IMAGE_NAME) .

# Vérifie le formatage sans modifier les fichiers
check-format:
	docker run --rm -v $(shell pwd):/app $(IMAGE_NAME) bash -c "find . -iname *.hpp -o -iname *.cpp | xargs clang-format --dry-run --Werror"

# Lance l'analyse statique et les tests
test:
	docker run --rm -v $(shell pwd):/app $(IMAGE_NAME) bash -c "\
		cppcheck --enable=all --inline-suppr --language=c++ --std=c++17 --error-exitcode=1 -I include/ . && \
		cmake -B $(BUILD_DIR) -S . && \
		cmake --build $(BUILD_DIR) && \
		cd $(BUILD_DIR) && ctest --output-on-failure"

clean:
	rm -rf $(BUILD_DIR) build/