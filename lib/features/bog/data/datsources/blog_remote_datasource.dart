import 'dart:io';

import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<Map?> publishBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required File file,
    required String imageName,
  });
  Future<List<Map>> getAllBlogs();
}

class BlogRemoteDatasourceImp implements BlogRemoteDatasource {
  final SupabaseClient supabase;
  BlogRemoteDatasourceImp({required this.supabase});

  @override
  Future<Map?> publishBlog(BlogModel blogModel) async {
    try {
      final List<Map> blogData = await supabase
          .from('blogs')
          .insert(blogModel.toMap())
          .select();
      return blogData.first;
    } on PostgrestException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File file,
    required String imageName,
  }) async {
    try {
      final String imageUrl = await supabase.storage
          .from('images')
          .upload(imageName, file);
      return imageUrl;
    } on StorageException {
      rethrow;
    }
  }

  @override
  Future<List<Map>> getAllBlogs() async {
    try {
      final List<Map> blogs = await supabase
          .from('blogs')
          .select('* , users(username)');
      return blogs;
    } on PostgrestException {
      rethrow;
    }
  }
}
