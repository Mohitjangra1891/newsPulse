// 1. Create an Article model
class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;
  final DateTime publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      sourceName: json['source']?['name'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
