// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final String id;
  final String email;
  final String name;
  final int? point;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.point,
  });


}
