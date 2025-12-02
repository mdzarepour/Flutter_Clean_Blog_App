import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/usecases/publish_blog_usecase.dart';
import 'package:blog/features/bog/presentation/bloc/status/publish_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final PublishBlogUsecase publishBlogUsecase;

  BlogBloc({required this.publishBlogUsecase})
    : super(BlogState(publishStatus: PublishInitial())) {
    on<PublishBlogEvent>(publishBlog);
  }

  FutureOr<void> publishBlog(event, emit) async {
    emit(state.copyWith(newPublishStatus: PublishLoading()));

    final Either either = await publishBlogUsecase.call(
      params: event.blogModel,
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
        emit(
          state.copyWith(newPublishStatus: PublishSuccess(blogEntity: blog)),
        );
      },
    );
  }
}
