import 'package:flutter/material.dart';
import 'package:global_state_package/global_state.dart';

void main() {
  runApp(const GlobalStateApp());
}

// Widget utama aplikasi
class GlobalStateApp extends StatefulWidget {
  const GlobalStateApp({super.key});

  @override
  GlobalStateAppState createState() => GlobalStateAppState();
}

// State untuk aplikasi dengan GlobalState
class GlobalStateAppState extends State<GlobalStateApp> {
  final GlobalState globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Advanced Counter App')),
        body: Column(
          children: [
            // Bagian untuk menampilkan daftar counter dengan drag-and-drop
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    globalState.reorderCounters(oldIndex, newIndex);
                  });
                },
                children: [
                  for (int index = 0; index < globalState.counters.length; index++)
                    AnimatedContainer(
                      key: ValueKey(globalState.counters[index]),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: globalState.counters[index].color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          'Counter ${index + 1}: ${globalState.counters[index].value}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Tombol decrement
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  globalState.decrementCounter(index);
                                });
                              },
                            ),
                            // Tombol increment
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  globalState.incrementCounter(index);
                                });
                              },
                            ),
                            // Tombol untuk mengganti warna counter
                            IconButton(
                              icon: const Icon(Icons.color_lens, color: Colors.white),
                              onPressed: () {
                                _pickColorForCounter(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Bagian untuk menambah dan menghapus counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      globalState.addCounter();
                    });
                  },
                  child: const Text('Add Counter'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (globalState.counters.isNotEmpty) {
                        globalState.removeCounter(globalState.counters.length - 1);
                      }
                    });
                  },
                  child: const Text('Remove Last Counter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dialog untuk memilih warna baru counter
  Future<void> _pickColorForCounter(int index) async {
    final Color? selectedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: blockPicker(
              pickerColor: globalState.counters[index].color,
              onColorChanged: (Color color) {
                Navigator.of(context).pop(color);
              },
            ),
          ),
        );
      },
    );

    if (selectedColor != null) {
      setState(() {
        globalState.changeCounterColor(index, selectedColor);
      });
    }
  }
  
  blockPicker({required Color pickerColor, required Null Function(Color color) onColorChanged}) {}
}
