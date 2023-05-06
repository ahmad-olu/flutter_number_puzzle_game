import 'package:flutter/material.dart';
import 'package:flutter_puzzle_game/model.dart';
import 'package:flutter_puzzle_game/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleGame extends StatelessWidget {
  const PuzzleGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(puzzleStateProvider);
                      final value = state[index];
                      final isEmpty = value == 0;
                      final color = isEmpty ? Colors.grey[300] : Colors.green;
                      return GestureDetector(
                        onTap: isEmpty
                            ? null
                            : () => ref
                                .read(puzzleStateProvider.notifier)
                                .move(index),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          color: color,
                          child: Center(
                            child: Text(
                              isEmpty ? '' : '$value',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () =>
                      ref.read(puzzleStateProvider.notifier).shuffle(),
                  child: const Text('Shuffle'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
