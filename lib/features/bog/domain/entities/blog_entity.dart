class BlogEntity {
  final String id;
  final String authorId;
  final String? authorUsername;
  final String title;
  final String content;
  final String topic;
  final String imageUrl;
  final String createdAt;

  BlogEntity({
    required this.id,
    required this.authorId,
    this.authorUsername,
    required this.content,
    required this.title,
    required this.topic,
    required this.imageUrl,
    required this.createdAt,
  });
}
