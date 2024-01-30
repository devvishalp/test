import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserDetails {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  const UserDetails(this.name, this.email);
}
