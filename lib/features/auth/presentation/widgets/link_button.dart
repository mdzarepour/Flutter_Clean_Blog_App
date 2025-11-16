import 'package:blog/common/theme/app_texttheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkButton extends StatelessWidget {
  final String routeName;
  final String title;
  final String text;
  const LinkButton({
    super.key,
    required this.title,
    required this.text,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(routeName),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Text(style: AppTexttheme.white17PoppinsRegular, text),
          Text(style: AppTexttheme.white17PoppinsRegular, title),
        ],
      ),
    );
  }
}
