import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUsecase
    implements Usecase<Future<Either<String, List<BlogEntity>>>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogsUsecase({required this.blogRepository});

  @override
  Future<Either<String, List<BlogEntity>>> call({
    required NoParams params,
  }) async {
    return await blogRepository.getAllBlogs();
  }
}
