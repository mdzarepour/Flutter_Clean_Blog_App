import 'package:blog/features/bog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.authorId,
    super.authorUsername,
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
  BlogModel copyWith({
    String? newId,
    String? newAuthorId,
    String? newContent,
    String? newTitle,
    String? newTopic,
    String? newImageUrl,
    String? newCreatedAt,
    String? newAuthourUsername,
  }) {
    return BlogModel(
      id: newId ?? id,
      authorId: newAuthorId ?? authorId,
      authorUsername: newAuthourUsername ?? authorUsername,
      content: newContent ?? content,
      title: newTitle ?? title,
      topic: newTopic ?? topic,
      imageUrl: newImageUrl ?? imageUrl,
      createdAt: newCreatedAt ?? createdAt,
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
      authorUsername: authorUsername,
    );
  }
}
