part of 'blog_bloc.dart';

sealed class BlogEvent {
  const BlogEvent();
}

class PublishBlogEvent extends BlogEvent {
  final UploadBlogParams uploadBlogParams;
  PublishBlogEvent({required this.uploadBlogParams});
}
