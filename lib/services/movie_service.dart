import 'package:dio/dio.dart';
import '../models/movie.dart';

class MovieService {
  final Dio _dio = Dio();

  final String apiKey = '43bfb323c2d8aa9dc782ce297c7b1cb9';

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
      },
    );

    List results = response.data['results'];

    return results.map((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
  final response = await _dio.get(
    'https://api.themoviedb.org/3/search/movie',
    queryParameters: {
      'api_key': apiKey,
      'query': query,
    },
  );

  List results = response.data['results'];

  return results.map((json) => Movie.fromJson(json)).toList();
}
}