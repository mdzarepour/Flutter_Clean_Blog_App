part of 'blog_bloc.dart';

class BlogState extends Equatable {
  final PublishStatus publishStatus;
  const BlogState({required this.publishStatus});

  BlogState copyWith({PublishStatus? newPublishStatus}) {
    return BlogState(publishStatus: newPublishStatus ?? publishStatus);
  }

  @override
  List<Object?> get props => [publishStatus];
}
