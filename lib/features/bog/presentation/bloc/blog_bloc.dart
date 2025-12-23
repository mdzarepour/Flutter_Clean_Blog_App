import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog/features/bog/domain/usecases/publish_blog_usecase.dart';
import 'package:blog/features/bog/presentation/bloc/status/get_blogs_status.dart';
import 'package:blog/features/bog/presentation/bloc/status/publish_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final PublishBlogUsecase publishBlogUsecase;
  final GetAllBlogsUsecase getAllBlogsUsecase;

  BlogBloc({required this.publishBlogUsecase, required this.getAllBlogsUsecase})
    : super(
        BlogState(
          getBlogsStatus: GetBlogsInitial(),
          publishStatus: PublishInitial(),
        ),
      ) {
    on<PublishBlogEvent>(publishBlog);
    on<GetAllBLogsEvent>(getAllBlogs);
  }

  FutureOr<void> publishBlog(PublishBlogEvent event, emit) async {
    emit(state.copyWith(newPublishStatus: PublishLoading()));
    final Either either = await publishBlogUsecase.call(
      params: event.uploadBlogParams,
    );
    either.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            newPublishStatus: PublishFail(errorMessage: errorMessage),
          ),
        );
      },
      (blog) {
        final currentBlogs = List<BlogEntity>.from(
          (state.getBlogsStatus as GetBlogsSuccess).blogsList,
        );
        currentBlogs.insert(0, blog);
        emit(
          state.copyWith(
            newGetBlogsStatus: GetBlogsSuccess(blogsList: currentBlogs),
            newPublishStatus: PublishSuccess(blogEntity: blog),
          ),
        );
      },
    );
  }

  FutureOr<void> getAllBlogs(event, emit) async {
    emit(state.copyWith(newGetBlogsStatus: GetBlogsLoading()));
    final Either either = await getAllBlogsUsecase.call(params: event.noParams);
    either.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            newGetBlogsStatus: GetBlogsFail(errorMessage: errorMessage),
          ),
        );
      },
      (blogsList) {
        emit(
          state.copyWith(
            newGetBlogsStatus: GetBlogsSuccess(blogsList: blogsList),
          ),
        );
      },
    );
  }
}
