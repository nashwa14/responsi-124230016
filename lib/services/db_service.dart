import 'package:hive/hive.dart';
import 'package:movie_app/models/movie_model.dart';

class DbService {
  static final Box _box = Hive.box('favorite');
  static List<Movie> getFavorites() {
    List raw = _box.get('list', defaultValue: []);
    return raw.map((e) => Movie.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  static Future<void> addFavorite(Movie movie) async {
    List<Movie> favs = getFavorites();
    favs.add(movie);
    await _box.put('list', favs.map((e) => e.toMap()).toList());
  }

  static Future<void> removeFavorite(int id) async {
    List<Movie> favs = getFavorites();
    favs.removeWhere((e) => e.id == id);
    await _box.put('list', favs.map((e) => e.toMap()).toList());
  }

}