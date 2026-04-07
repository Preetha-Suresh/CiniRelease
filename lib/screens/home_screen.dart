import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import 'detail_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final MovieService _service = MovieService();
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    final data = await _service.getNowPlayingMovies();

    setState(() {
      movies = data;
      isLoading = false;
    });
  }

  void searchMovies(String query) async {
    if (query.isEmpty) {
      fetchMovies(); // reload original list
      return;
    }

    final data = await _service.searchMovies(query);

    setState(() {
      movies = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: searchMovies,
          decoration: const InputDecoration(
            hintText: "Search movies...",
            border: InputBorder.none,
          ),
        ),
        actions: [
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WatchlistScreen(),
              ),
            );
          },
        )
      ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              
              itemBuilder: (context, index) {
                final movie = movies[index];

                                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        height: 200,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("⭐ ${movie.rating}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}