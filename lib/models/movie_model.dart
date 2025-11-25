class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String image;
  final String rating;
  final String genre;
  final String createdAt;
  final String description;
  final String director;
  final String cast;
  final String language;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.image,
    required this.rating,
    required this.genre,
    required this.createdAt,
    required this.description,
    required this.director,
    required this.cast,
    required this.language,
    required this.duration,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'genre': genre,
    'image': image,
    'rating': rating,
    'director': director,
    'cast': cast,
    'language': language,
    'duration': duration,
    'releaseDate': releaseDate,
    'created_at': createdAt,
    'description': description,
  };

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
    id: map['id'],
    title: map['title'],
    genre: map['genre'],
    image: map['image'],
    rating: map['rating'],
    director: map['director'],
    cast: map['cast'],
    language: map['language'],
    duration: map['duration'],
    releaseDate: map['releaseDate'],
    createdAt: map['createdAt'],
    description: map['description'],
  );
}
