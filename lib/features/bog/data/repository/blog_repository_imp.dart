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
  }) async {
    try {
      final Map? blogData = await blogRemoteDatasource.publishBlog(blogModel);
      if (blogData == null || blogData.isEmpty) {
        return left('cant publish this blog');
      }
      final BlogModel model = BlogModel.fromJson(map: blogData);
      return right(model.toEntity());
    } on PostgrestException catch (e) {
      return left(e.message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
