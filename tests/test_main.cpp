#include <iostream>
#include <cassert>
#include "ring_buffer.hpp"

int main() {
    RingBuffer rb(3);

    // Test 1 : Le buffer est vide au début
    assert(rb.empty() == true);

    // Test 2 : On ajoute des éléments
    rb.push(10);
    rb.push(20);
    assert(rb.empty() == false);

    // Test 3 : On récupère un élément
    auto val = rb.pop();
    assert(val.has_value() && val.value() == 10);

    std::cout << "TOUS LES TESTS SONT PASSÉS ! (Vert 🟢)" << std::endl;
    return 0;
}