import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:blog/core/common/widgets/loading_widget.dart';
import 'package:blog/core/secret/app_secrets.dart';
import 'package:blog/core/utils/time_helper.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadBlogPage extends StatelessWidget {
  final BlogEntity blog;
  final TimeHelper timeHelper = locator.get();
  ReadBlogPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(style: AppTextTheme.white30PoppinsBold, blog.title),
          SizedBox(height: 15),
          blogAuthor(),
          blogDetails(),
          SizedBox(height: 20),
          blogImage(),
          SizedBox(height: 25),
          blogContent(),
        ],
      ),
    );
  }

  Widget blogContent() {
    return Text(
      style: AppTextTheme.white17PoppinsRegular.copyWith(height: 2),
      blog.content,
    );
  }

  Widget blogAuthor() {
    return Text(
      style: AppTextTheme.grey20DmSansRegular,
      'by ${blog.authorUsername}',
    );
  }

  Widget blogDetails() {
    return Row(
      spacing: 20,
      children: [
        Text(
          style: AppTextTheme.grey20DmSansRegular,
          timeHelper.formatBlogDate(blog.createdAt),
        ),
        Text(
          style: AppTextTheme.grey20DmSansRegular,
          '${timeHelper.calculateReadingTime(content: blog.content)} min',
        ),
      ],
    );
  }

  Widget blogImage() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.materialSoftGrey,
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
        child: CachedNetworkImage(
          placeholder: (context, url) => LoadingWidget(),
          errorWidget: (context, url, error) => Icon(CupertinoIcons.photo),
          imageUrl: '${AppSecrets.baseUrl}${blog.imageUrl}',
        ),
      ),
    );
  }
}
