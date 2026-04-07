import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'package:hive/hive.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text("⭐ ${movie.rating}"),
            const SizedBox(height: 5),
            Text("Release: ${movie.releaseDate}"),
            ElevatedButton(
              onPressed: () {
                final box = Hive.box('watchlist');
                box.put(movie.id, movie.title);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Watchlist")),
                );
              },
              child: const Text("Add to Watchlist"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Overview",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(movie.overview),
          ],
        ),
      ),
    );
  }
}