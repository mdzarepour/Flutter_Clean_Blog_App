import 'dart:io';

import 'package:blog/features/bog/data/datsources/blog_remote_datasource.dart';
import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  BlogRepositoryImp({required this.blogRemoteDatasource});

  @override
  Future<Either<String, BlogEntity>> publishBlog({
    required BlogModel blogModel,
    required File file,
  }) async {
    try {
      final Map? blogData = await blogRemoteDatasource.publishBlog(blogModel);
      if (blogData == null || blogData.isEmpty) {
        return left('cant publish this blog');
      }
      final BlogModel model = BlogModel.fromJson(map: blogData);
      await blogRemoteDatasource.uploadBlogImage(
        imageName: model.imageUrl,
        file: file,
      );

      return right(model.toEntity());
    } on PostgrestException catch (e) {
      return left(e.message);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BlogEntity>>> getAllBlogs() async {
    try {
      final List<Map> blogsData = await blogRemoteDatasource.getAllBlogs();
      final List<BlogEntity> blogs = blogsData
          .map<BlogEntity>(
            (e) => BlogModel.fromJson(
              map: e,
            ).copyWith(newAuthourUsername: e['users']['username']).toEntity(),
          )
          .toList();
      return right(blogs);
    } on PostgrestException catch (e) {
      return left(e.message);
    }
  }
}
