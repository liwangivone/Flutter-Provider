library global_state_package;

import 'dart:math';
import 'package:flutter/material.dart';

class CounterItem {
  int value; // Nilai counter
  Color color; // Warna counter

  CounterItem({required this.value, required this.color});
}

class GlobalState {
  // List untuk menyimpan data counter (nilai dan warna)
  final List<CounterItem> counters = [];

  // Fungsi untuk menambah counter baru dengan warna random
  void addCounter() {
    counters.add(CounterItem(
      value: 0,
      color: _generateRandomColor(),
    ));
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
      counters[index].value++;
    }
  }

  // Fungsi untuk mengurangi (decrement) nilai counter berdasarkan indeks
  void decrementCounter(int index) {
    if (index >= 0 && index < counters.length && counters[index].value > 0) {
      counters[index].value--;
    }
  }

  // Fungsi untuk mengganti warna counter berdasarkan indeks
  void changeCounterColor(int index, Color newColor) {
    if (index >= 0 && index < counters.length) {
      counters[index].color = newColor;
    }
  }

  // Fungsi untuk memindahkan posisi counter dalam list
  void reorderCounters(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = counters.removeAt(oldIndex);
    counters.insert(newIndex, item);
  }

  // Helper untuk menghasilkan warna random
  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
