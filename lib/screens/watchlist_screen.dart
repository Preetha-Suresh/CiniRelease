import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('watchlist');
    final items = box.keys.toList(); // Use keys so we can remove by ID

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
      ),
      body: items.isEmpty
          ? const Center(child: Text("No movies saved"))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final key = items[index];
                final value = box.get(key, defaultValue: 'Unknown Movie');

                return ListTile(
                  title: Text(value),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.delete(key); // Remove from Hive
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Removed from Watchlist")),
                      );
                      // Refresh UI
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
              },
            ),
    );
  }
}