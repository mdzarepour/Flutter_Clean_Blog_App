import 'package:blog/features/bog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.authorId,
    required super.content,
    required super.title,
    required super.topic,
    required super.imageUrl,
    required super.createdAt,
  });

  factory BlogModel.fromJson({required Map map}) {
    return BlogModel(
      id: map['id'],
      title: map['title'],
      topic: map['topics'],
      content: map['content'],
      authorId: map['author_id'],
      imageUrl: map['image_url'],
      createdAt: map['created_at'],
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'title': title,
      'topics': topic,
      'content': content,
      'author_id': authorId,
      'image_url': imageUrl,
      'created_at': createdAt,
    };
  }

  BlogEntity toEntity() {
    return BlogEntity(
      id: id,
      authorId: authorId,
      content: content,
      title: title,
      topic: topic,
      imageUrl: imageUrl,
      createdAt: createdAt,
    );
  }
}
