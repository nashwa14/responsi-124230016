import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/detail_page.dart';
import 'package:movie_app/screens/favorite_screen.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/widgets/movie_card.dart';


class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> movies = [];
  List<Movie> displayMovies = [];
  String username = "";
  String selectedGenre = "All";

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    username = await AuthService.getUsername() ?? "";
    movies = await ApiService.getMovies();
    displayMovies = movies;
    setState(() {});
  }

  filterGenre(String genre) {
    selectedGenre = genre;

    if (genre == "All") {
      displayMovies = movies;
    } else {
      displayMovies = movies
      .where((e) => e.genre.toLowerCase() == genre.toLowerCase())
      .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final genres = [
      "All",
      ...{...movies.map((e) => e.genre)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Halo, $username"),
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
        ],
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: selectedGenre,
                    isExpanded: true,
                    items: genres
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (v) => filterGenre(v!),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: displayMovies.length,
                    itemBuilder: (context, i) {
                      final movie = displayMovies[i];
                      return MovieCard(
                        movie: movie,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
