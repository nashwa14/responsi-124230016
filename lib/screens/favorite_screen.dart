import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/db_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> favorites = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    favorites = await DbService.getFavorites();
    setState(() {});
  }

  delete(Movie movie) async {
    await DbService.removeFavorite(movie.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${movie.title} dihapus dari favorite"),
        backgroundColor: Colors.red,
      ),
    );
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        backgroundColor: Colors.pink[200],
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("Belum ada Favorite"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                final m = favorites[i];
                return ListTile(
                  leading: Image.network(m.image),
                  title: Text(m.title),
                  subtitle: Text(m.genre),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => delete(m),
                  ),
                );
              },
            ),
    );
  }
}
