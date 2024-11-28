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
  // Inisialisasi GlobalState
  final GlobalState globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Advanced Counter App')),
        body: Column(
          children: [
            // Bagian untuk menampilkan daftar counter
            Expanded(
              child: ListView.builder(
                itemCount: globalState.counters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // Menampilkan nilai dari setiap counter
                    title: Text('Counter ${index + 1}: ${globalState.counters[index]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol decrement untuk mengurangi nilai counter
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              globalState.decrementCounter(index);
                            });
                          },
                        ),
                        // Tombol increment untuk menambah nilai counter
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              globalState.incrementCounter(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bagian untuk menambah dan menghapus counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol untuk menambahkan counter baru
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      globalState.addCounter();
                    });
                  },
                  child: const Text('Add Counter'),
                ),
                const SizedBox(width: 10),
                // Tombol untuk menghapus counter terakhir
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
}
