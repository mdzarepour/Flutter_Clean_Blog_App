import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthLocalDatasource {
  void saveUserInDB({required final UserModel userModel});
  Future<UserModel?> getCurrentUserFromDB();
}

class AuthLocalDatasourceImp implements AuthLocalDatasource {
  final SupabaseClient supabase;
  AuthLocalDatasourceImp({required this.supabase});

  @override
  saveUserInDB({required UserModel userModel}) async {
    try {
      await supabase.from('users').upsert({
        'id': userModel.id,
        'created_at': userModel.createdAt,
        'updated_at': userModel.updatedAt,
        'email': userModel.email,
        'username': userModel.username,
        'password': userModel.createdAt,
      });
    } on PostgrestException {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getCurrentUserFromDB() async {
    try {
      final Session? session = supabase.auth.currentSession;
      if (session == null) {
        return null;
      }
      final List<Map> userData = await supabase
          .from('users')
          .select()
          .eq('id', session.user.id);
      final UserModel userModel = UserModel.fromJson(map: userData.first);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
