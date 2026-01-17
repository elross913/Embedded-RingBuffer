cmake_minimum_required(VERSION 3.10)
project(EmbeddedRingBuffer VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# On inclut le dossier include
include_directories(include)

# On ajoute l'exécutable de test
add_executable(unit_tests tests/test_main.cpp)

# On active les tests
enable_testing()
add_test(NAME BufferTests COMMAND unit_tests)