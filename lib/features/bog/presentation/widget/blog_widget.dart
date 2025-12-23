import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:blog/core/utils/time_helper.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogWidget extends StatelessWidget {
  final BlogEntity blog;
  final TimeHelper timeHelper = locator.get();

  BlogWidget({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.materialSoftGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 15,
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  blog.title,
                  style: AppTextTheme.white22PoppinsRegular,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  style: AppTextTheme.grey15DmSansRegular,
                  '${timeHelper.calculateReadingTime(content: blog.content)} min',
                ),
              ),
            ],
          ),
          Text(
            style: AppTextTheme.grey20DmSansRegular,
            'By ${blog.authorUsername ?? 'unknown author'}',
          ),
          Row(spacing: 10, children: [topicWidget(), topicWidget()]),
        ],
      ),
    );
  }

  Container topicWidget() {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: AppColors.materialSoftGrey,
      ),
      child: Center(
        child: Text(style: AppTextTheme.grey15DmSansRegular, blog.topic),
      ),
    );
  }
}
