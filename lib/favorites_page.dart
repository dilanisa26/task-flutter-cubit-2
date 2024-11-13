import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      color: const Color.fromARGB(255, 240, 240, 240),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Anisaaa, Kamu memiliki ${appState.favorites.length} kata favorite.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 12, 100, 42),
                  ),
            ),
          ),
          ...appState.favorites.map(
            (pair) => Card(
              elevation: 2,
              color: const Color.fromARGB(255, 251, 253, 253),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: const Color.fromARGB(255, 12, 100, 42),
                ),
                title: Text(
                  pair.asLowerCase,
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 12, 100, 42),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: const Color.fromARGB(255, 206, 205, 205),
                  ),
                  onPressed: () {
                    // Show confirmation dialog to remove the favorite
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Remove Favorite'),
                          content: Text(
                              'Remove "${pair.asLowerCase}" from favorites?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                appState.removeFavorite(pair);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Removed from favorites'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Text('Remove'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                onTap: () {
                  // Show SnackBar when tapped with the word message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("It's ${pair.asLowerCase}!"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
