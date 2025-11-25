import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            movie.image,
            width: 60,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (ctx, error, stack) {
              return const Icon(Icons.broken_image, size: 40);
            },
          ),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text("${movie.genre} • ${movie.releaseDate}"),
        trailing: Text(
          movie.rating.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
