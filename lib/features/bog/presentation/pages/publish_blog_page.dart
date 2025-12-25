import 'dart:io';

import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/core/common/widgets/custom_input.dart';
import 'package:blog/core/common/widgets/loading_widget.dart';
import 'package:blog/core/utils/image_helper.dart';
import 'package:blog/core/utils/widget_helper.dart';
import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:blog/features/bog/domain/usecases/publish_blog_usecase.dart';
import 'package:blog/features/bog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/bog/presentation/bloc/status/publish_status.dart';
import 'package:blog/features/bog/presentation/widget/grey_card_widget.dart';
import 'package:blog/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class PublishBlogPage extends StatefulWidget {
  const PublishBlogPage({super.key});

  @override
  State<PublishBlogPage> createState() => _PublishBlogPageState();
}

class _PublishBlogPageState extends State<PublishBlogPage> {
  final TextEditingController blogTitleController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();

  final List<String> topics = ['science', 'backend', 'frontend'];
  int? selectedIndex;

  final WidgetHelper widgetHelper = locator.get();
  final ImageHelper imageHelper = locator.get();
  File? imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Blog')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 25,
              children: [
                _pickImageButton(),
                _categoryList(),
                _titleField(),
                _contentField(),
                _publishButton(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickImageButton() {
    return Expanded(
      child: FilledButton(
        onPressed: () => _selectBanner(),
        child: imageFile != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  child: Image.file(imageFile!, fit: BoxFit.cover),
                ),
              )
            : Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    size: 30,
                    color: AppColors.materialGrey,
                    CupertinoIcons.folder,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    style: AppTextTheme.grey20DmSansRegular,
                    'Select Banner Image',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _categoryList() {
    return Row(
      spacing: 10,
      children: [
        for (int i = 0; i < topics.length; i++)
          GreyCardWidget(
            isSelected: selectedIndex == i ? true : false,
            onTap: () => _selectCategory(i),
            child: Text(style: AppTextTheme.grey15DmSansRegular, topics[i]),
          ),
      ],
    );
  }

  Widget _contentField() {
    return CustomInput(
      controller: blogContentController,
      hint: 'Blog Content',
      icon: CupertinoIcons.text_aligncenter,
    );
  }

  Widget _titleField() {
    return CustomInput(
      controller: blogTitleController,
      hint: 'Blog Title',
      icon: CupertinoIcons.pen,
    );
  }

  Widget _publishButton() {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: FilledButton(
        onPressed: () => _publishBlog(),
        child: BlocConsumer<BlogBloc, BlogState>(
          builder: (context, state) {
            final status = state.publishStatus;
            if (status is PublishLoading) {
              return LoadingWidget();
            }
            return Text(
              style: AppTextTheme.white17PoppinsRegular,
              'Publish Blog',
            );
          },
          listener: (context, state) {
            final status = state.publishStatus;
            if (status is PublishSuccess) {
              widgetHelper.showSnackbar(
                message: '${status.blogEntity!.title} published successfully',
              );
              context.pop();
            }
            if (status is PublishFail) {
              widgetHelper.showSnackbar(message: status.errorMessage);
            }
          },
        ),
      ),
    );
  }

  _publishBlog() {
    if (_formKey.currentState!.validate()) {
      if (imageFile != null && selectedIndex != null) {
        final authorId = context.read<UserCubit>().state as UserExist;
        BlocProvider.of<BlogBloc>(context).add(
          PublishBlogEvent(
            uploadBlogParams: UploadBlogParams(
              blogModel: BlogModel(
                id: Uuid().v1(),
                createdAt: DateTime.now().toIso8601String(),
                authorId: authorId.userEntity!.id,
                content: blogContentController.text,
                title: blogTitleController.text,
                topic: topics[selectedIndex!],
                imageUrl: imageFile!.path.split('/').last,
              ),
              file: imageFile!,
            ),
          ),
        );
      }
    }
  }

  _selectBanner() async {
    final pickedImage = await imageHelper.pickImageFromGallery();
    setState(() {
      imageFile = pickedImage;
    });
  }

  _selectCategory(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    blogContentController.dispose();
    blogTitleController.dispose();
  }
}
