part of 'blog_bloc.dart';

sealed class BlogEvent {
  const BlogEvent();
}

class PublishBlogEvent extends BlogEvent {
  final BlogModel blogModel;
  PublishBlogEvent({required this.blogModel});
}
