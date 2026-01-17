#ifndef RING_BUFFER_HPP
#define RING_BUFFER_HPP

#include <vector>
#include <optional>
#include <mutex>

class RingBuffer {
public:
    explicit RingBuffer(size_t size) : buffer(size), max_size(size) {}

    // Ajoute un élément au buffer
    void push(int item) {
        std::lock_guard<std::mutex> lock(mtx);
        buffer[head] = item;
        head = (head + 1) % max_size;
        
        if (full) {
            tail = (tail + 1) % max_size;
        }
        full = head == tail;
    }

    // Récupère un élément (retourne un optional si vide)
    std::optional<int> pop() {
        std::lock_guard<std::mutex> lock(mtx);
        if (empty()) {
            return std::nullopt;
        }

        auto val = buffer[tail];
        full = false;
        tail = (tail + 1) % max_size;
        return val; 
    }

    bool empty() const {
        return (!full && (head == tail));
    }

private:
    std::vector<int> buffer;
    size_t head = 0;
    size_t tail = 0;
    size_t max_size;
    bool full = false;
    std::mutex mtx; // Pour la thread-safety (important en temps réel)
};

#endif