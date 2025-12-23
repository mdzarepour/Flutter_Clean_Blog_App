part of 'blog_bloc.dart';

class BlogState extends Equatable {
  final PublishStatus publishStatus;
  final GetBlogsStatus getBlogsStatus;
  const BlogState({required this.publishStatus, required this.getBlogsStatus});

  BlogState copyWith({
    GetBlogsStatus? newGetBlogsStatus,
    PublishStatus? newPublishStatus,
  }) {
    return BlogState(
      getBlogsStatus: newGetBlogsStatus ?? getBlogsStatus,
      publishStatus: newPublishStatus ?? publishStatus,
    );
  }

  @override
  List<Object?> get props => [publishStatus, getBlogsStatus];
}
