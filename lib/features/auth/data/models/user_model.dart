import 'package:blog/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.aud,
    required super.createdAt,
    required super.emailVerified,
    required super.updatedAt,
  });

  factory UserModel.fromJson({required Map<String, dynamic> map}) {
    return UserModel(
      id: map["id"].toString(),
      email: map["email"].toString(),
      username: map["user_metadata"]["username"].toString(),
      aud: map["aud"].toString(),
      createdAt: map["created_at"].toString(),
      emailVerified: map["user_metadata"]["email_verified"].toString(),
      updatedAt: map["updated_at"].toString(),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      aud: aud,
      createdAt: createdAt,
      emailVerified: emailVerified,
      updatedAt: updatedAt,
    );
  }
}
