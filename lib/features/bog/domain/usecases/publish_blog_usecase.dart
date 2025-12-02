import 'dart:io';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class PublishBlogUsecase
    implements Usecase<Future<Either<String, BlogEntity>>, UploadBlogParams> {
  final BlogRepository blogRepository;
  PublishBlogUsecase({required this.blogRepository});

  @override
  Future<Either<String, BlogEntity>> call({
    required UploadBlogParams params,
  }) async {
    return await blogRepository.publishBlog(
      blogModel: params.blogModel,
      file: params.file,
    );
  }
}

class UploadBlogParams {
  final BlogModel blogModel;
  final File file;
  UploadBlogParams({required this.blogModel, required this.file});
}
