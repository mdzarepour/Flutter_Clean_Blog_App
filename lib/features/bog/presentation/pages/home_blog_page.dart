import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:blog/core/common/widgets/loading_widget.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/utils/widget_helper.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/bog/presentation/bloc/status/get_blogs_status.dart';
import 'package:blog/features/bog/presentation/widget/blog_widget.dart';
import 'package:blog/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBlogPage extends StatefulWidget {
  const HomeBlogPage({super.key});

  @override
  State<HomeBlogPage> createState() => _HomeBlogPageState();
}

class _HomeBlogPageState extends State<HomeBlogPage> {
  final WidgetHelper widgetHelper = locator.get();

  @override
  void initState() {
    context.read<BlogBloc>().add(GetAllBLogsEvent(noParams: NoParams()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0, title: Text('Blog App')),
      body: Center(
        child: BlocConsumer<BlogBloc, BlogState>(
          builder: (context, state) {
            final status = state.getBlogsStatus;
            if (status is GetBlogsLoading) return LoadingWidget();
            if (status is GetBlogsSuccess) return successWidget(status);
            return SizedBox.shrink();
          },
          listener: (context, state) {
            final status = state.getBlogsStatus;
            if (status is GetBlogsFail) {
              widgetHelper.showSnackbar(message: status.errorMessage);
            }
          },
        ),
      ),
      floatingActionButton: addBlogButton(context),
    );
  }

  Widget successWidget(GetBlogsSuccess status) {
    List<BlogEntity> blogsList = status.blogsList;
    final emptyState = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        Icon(size: 35, color: AppColors.materialGrey, Icons.data_array),
        Text(
          textAlign: TextAlign.center,
          style: AppTextTheme.grey20DmSansRegular,
          'there is no published blogs',
        ),
      ],
    );
    final filledState = ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 15),
      itemCount: blogsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              context.push(extra: blogsList[index], RouterNames.readBlogPage),
          child: BlogWidget(blog: blogsList[index]),
        );
      },
    );

    return blogsList.isEmpty ? emptyState : filledState;
  }

  Widget addBlogButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(CupertinoIcons.add),
      onPressed: () => context.push(RouterNames.addBlogPage),
    );
  }
}
