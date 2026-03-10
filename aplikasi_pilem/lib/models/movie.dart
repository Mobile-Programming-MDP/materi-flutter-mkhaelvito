class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double VoteAvarage;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.VoteAvarage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_Patch'] ?? '',
      backdropPath:   json['backdrop_Patch'] ?? '',
      releaseDate: json['release_Date'] ?? '',
      VoteAvarage: (json['Vote_Avarage'] as num).toDouble(),
    );
  }
}
