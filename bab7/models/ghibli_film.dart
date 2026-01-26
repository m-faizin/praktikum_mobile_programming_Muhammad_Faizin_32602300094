class GhibliFilm {
  final String id;
  final String title;
  final String description;
  final String director;
  final String releaseDate;
  final String image;
  
  GhibliFilm({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.releaseDate,
    required this.image,
  });

  factory GhibliFilm.fromJson(Map<String, dynamic> json) {
    return GhibliFilm(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      director: json['director'] ?? 'Unknown',
      releaseDate: json['release_date'] ?? 'Unknown',
      image: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
}