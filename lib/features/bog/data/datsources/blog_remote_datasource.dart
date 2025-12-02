import 'package:blog/features/bog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<Map?> publishBlog(BlogModel blogModel);
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
}
