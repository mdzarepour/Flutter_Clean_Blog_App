class UserEntity {
  final String id;
  final String email;
  final String username;
  final String password;
  final String createdAt;
  final String updatedAt;
  final String role;

  UserEntity({
    required this.role,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
}
