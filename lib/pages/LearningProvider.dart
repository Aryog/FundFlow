import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fundflow/pages/fav_movies.dart';
import 'package:fundflow/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class AppLearnScreen extends StatefulWidget {
  const AppLearnScreen({super.key});

  @override
  State<AppLearnScreen> createState() => _AppLearnScreenState();
}

class _AppLearnScreenState extends State<AppLearnScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MovieProvider>().movies;
    final myList = context.watch<MovieProvider>().myList;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Provider'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAppListScreen()));
                },
                icon: const Icon(Icons.favorite),
                label: Text(
                  "Go to my list (${myList.length})",
                  style: const TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 20)),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (_, index) {
                        final currentMovie = movies[index];
                        return Card(
                          key: ValueKey(currentMovie.title),
                          color: Colors.blue,
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              currentMovie.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              currentMovie.duration ?? 'No information',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.favorite,
                                  color: myList.contains(currentMovie)
                                      ? Colors.red
                                      : Colors.white),
                              onPressed: () {
                                if (!myList.contains(currentMovie)) {
                                  context
                                      .read<MovieProvider>()
                                      .addToList(currentMovie);
                                } else {
                                  context
                                      .read<MovieProvider>()
                                      .removeFromList(currentMovie);
                                }
                              },
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
