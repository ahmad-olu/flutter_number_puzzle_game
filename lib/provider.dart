import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleStateProvider =
    StateNotifierProvider<PuzzleNotifier, List<int>>((ref) => PuzzleNotifier());

class PuzzleNotifier extends StateNotifier<List<int>> {
  PuzzleNotifier() : super(List.generate(16, (i) => i));

  void shuffle() {
    final random = Random();
    for (var i = state.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = state[i];
      state[i] = state[j];
      state[j] = temp;
    }
    state = [...state];
  }

  void move(int index) {
    final emptyIndex = state.indexOf(0);
    final row = emptyIndex ~/ 4;
    final col = emptyIndex % 4;
    final indexRow = index ~/ 4;
    final indexCol = index % 4;
    if ((row == indexRow && (col - indexCol).abs() == 1) ||
        (col == indexCol && (row - indexRow).abs() == 1)) {
      state[emptyIndex] = state[index];
      state[index] = 0;
      state = [...state];
    }
  }

  bool isComplete() {
    for (var i = 0; i < state.length - 1; i++) {
      if (state[i] != i + 1) {
        return false;
      }
    }
    return true;
  }
}
