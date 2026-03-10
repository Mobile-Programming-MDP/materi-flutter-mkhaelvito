import 'package:aplikasi_pilem/models/movie.dart';
import 'package:aplikasi_pilem/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesData = await _apiServices
        .getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesData = await _apiServices
        .getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesData = await _apiServices
        .getPopularMovies();

    setState(() {
      _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
      _trendingMovies = trendingMoviesData
          .map((e) => Movie.fromJson(e))
          .toList();
      _popularMovies = popularMoviesData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilem')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieList("All Movies", _allMovies),
            _buildMovieList("Trending Movies", _trendingMovies),
            _buildMovieList("Popular Movies", _popularMovies),
          ],
        ),
      ),
    );
  }
}

Widget _buildMovieList(String title, List<Movie> movies) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 200,
        child: ,
      )
    ],
  );
}
