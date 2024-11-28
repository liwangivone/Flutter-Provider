class GlobalState {
  // List untuk menyimpan nilai dari setiap counter
  final List<int> counters = [];

  // Fungsi untuk menambah counter baru
  void addCounter() {
    counters.add(0); // Nilai awal counter baru adalah 0
  }

  // Fungsi untuk menghapus counter berdasarkan indeks
  void removeCounter(int index) {
    if (index >= 0 && index < counters.length) {
      counters.removeAt(index);
    }
  }

  // Fungsi untuk menambah (increment) nilai counter berdasarkan indeks
  void incrementCounter(int index) {
    if (index >= 0 && index < counters.length) {
      counters[index]++;
    }
  }

  // Fungsi untuk mengurangi (decrement) nilai counter berdasarkan indeks
  void decrementCounter(int index) {
    if (index >= 0 && index < counters.length && counters[index] > 0) {
      counters[index]--;
    }
  }
}
