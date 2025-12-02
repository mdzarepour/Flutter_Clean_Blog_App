import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class PublishBlogUsecase
    implements Usecase<Future<Either<String, BlogEntity>>, BlogModel> {
  final BlogRepository blogRepository;
  PublishBlogUsecase({required this.blogRepository});

  @override
  Future<Either<String, BlogEntity>> call({required BlogModel params}) async {
    return await blogRepository.publishBlog(blogModel: params);
  }
}
