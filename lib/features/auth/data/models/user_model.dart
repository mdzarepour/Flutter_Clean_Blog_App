import 'package:blog/core/common/user/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromResponse({required User user}) {
    return UserModel(
      id: user.id,
      email: user.email!,
      username: user.userMetadata!['username'],
      password: user.userMetadata!['password'],
      createdAt: user.createdAt,
      updatedAt: user.createdAt,
    );
  }
  factory UserModel.fromJson({required Map map}) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      createdAt: createdAt,
      updatedAt: updatedAt,
      password: password,
    );
  }
}
