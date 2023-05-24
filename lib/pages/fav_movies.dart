import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fundflow/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MyAppListScreen extends StatefulWidget {
  const MyAppListScreen({super.key});

  @override
  State<MyAppListScreen> createState() => _MyAppListScreenState();
}

class _MyAppListScreenState extends State<MyAppListScreen> {
  @override
  Widget build(BuildContext context) {
    final _myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(title: Text("My List (${_myList.length})")),
      body: ListView.builder(
          itemCount: _myList.length,
          itemBuilder: (_, index) {
            final currentMovie = _myList[index];
            return Card(
              key: ValueKey(currentMovie.title),
              elevation: 4,
              child: ListTile(
                title: Text(currentMovie.title),
                subtitle: Text(currentMovie.duration ?? ''),
                trailing: TextButton(
                  child: const Text(
                    "Remove",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context.read<MovieProvider>().removeFromList(currentMovie);
                  },
                ),
              ),
            );
          }),
    );
  }
}
