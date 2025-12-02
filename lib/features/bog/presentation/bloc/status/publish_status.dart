import 'package:blog/features/bog/domain/entities/blog_entity.dart';

abstract class PublishStatus {}

class PublishInitial extends PublishStatus {}

class PublishLoading extends PublishStatus {}

class PublishSuccess extends PublishStatus {
  final BlogEntity? blogEntity;
  PublishSuccess({this.blogEntity});
}

class PublishFail extends PublishStatus {
  final String errorMessage;
  PublishFail({required this.errorMessage});
}
