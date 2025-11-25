import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/db_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFav();
  }

  checkFav() async {
    final favs = await DbService.getFavorites();
    isFavorite = favs.any((e) => e.id == widget.movie.id);
    setState(() {});
  }

  toggleFav() async {
    if (isFavorite) {
      await DbService.removeFavorite(widget.movie.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dihapus dari Favorite"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      await DbService.addFavorite(widget.movie);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ditambahkan ke Favorite"),
          backgroundColor: Colors.green,
        ),
      );
    }
    checkFav();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(m.title),
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFav,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(m.image, height: 220),
            const SizedBox(height: 16),
            Text(m.title, style: const TextStyle(fontSize: 22)),
            Text("Genre: ${m.genre}"),
            Text("Rating: ${m.rating}"),
            Text("Tanggal Rilis: ${m.releaseDate}"),
            const SizedBox(height: 10),
            Text(m.description),
          ],
        ),
      ),
    );
  }
}
