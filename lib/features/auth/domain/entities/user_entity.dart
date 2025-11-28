class UserEntity {
  final String id;
  final String email;
  final String username;
  final String aud;
  final String createdAt;
  final String emailVerified;
  final String updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.aud,
    required this.createdAt,
    required this.emailVerified,
    required this.updatedAt,
  });
}
