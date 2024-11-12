import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      color: const Color.fromARGB(255, 240, 240, 240), // Light gray background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'There are ur Words History:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 202, 61, 96),
                      ),
                ),
                if (appState.history.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog to clear history
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Clear History'),
                            content: Text('Are you sure you want to clear all history?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  appState.clearHistory();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('All history words removed!'),
                                    ),
                                  );
                                },
                                child: Text('Clear'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Clear All'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 202, 61, 96),
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: appState.history.length,
              itemBuilder: (context, index) {
                var pair = appState.history[index];
                return Card(
                  elevation: 2,
                  color: const Color.fromARGB(255, 252, 254, 254), // Light card color
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      pair.asLowerCase,
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 202, 61, 96),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      // Show a Snackbar with the word when tapped
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${pair.asLowerCase}!"),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
