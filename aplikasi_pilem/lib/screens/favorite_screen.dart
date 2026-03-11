import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:aplikasi_pilem/models/movie.dart';
import 'package:aplikasi_pilem/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> _favorites = [];

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Gunakan key 'favorites' yang sama dengan detail_screen.dart
    List<String> favList = prefs.getStringList('favorites') ?? [];
    List<Movie> favorites = favList.map((item) {
      Movie movie = Movie.fromJson(jsonDecode(item));
      movie.isFavorite = true;
      return movie;
    }).toList();

    setState(() {
      _favorites = favorites;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    // Hapus Scaffold di sini, langsung return body-nya saja
    return _favorites.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum ada film favorit',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: _favorites.length,
            itemBuilder: (context, index) {
              final Movie movie = _favorites[index];
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                ).then((_) => _loadFavorites()),
              );
            },
          );
  }
}