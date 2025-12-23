import 'package:blog/features/bog/domain/entities/blog_entity.dart';

abstract class GetBlogsStatus {}

class GetBlogsInitial extends GetBlogsStatus {}

class GetBlogsLoading extends GetBlogsStatus {}

class GetBlogsSuccess extends GetBlogsStatus {
  final List<BlogEntity> blogsList;
  GetBlogsSuccess({required this.blogsList});
}

class GetBlogsFail extends GetBlogsStatus {
  final String errorMessage;
  GetBlogsFail({required this.errorMessage});
}
