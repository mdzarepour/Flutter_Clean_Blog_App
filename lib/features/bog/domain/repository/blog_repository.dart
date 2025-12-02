import 'dart:io';

import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<String, BlogEntity>> publishBlog({
    required BlogModel blogModel,
    required File file,
  });
}
