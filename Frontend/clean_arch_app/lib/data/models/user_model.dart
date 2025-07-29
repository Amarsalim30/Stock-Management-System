import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/permission.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    String? phoneNumber,
    String? department,
    List<PermissionType>? permissions,
    bool isActive = true,
    DateTime? lastLogin,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
         id: id,
         name: name,
         email: email,
         role: role,
         phoneNumber: phoneNumber,
         department: department,
         permissions: permissions,
         isActive: isActive,
         lastLogin: lastLogin,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Helper method to convert from entity to model
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      phoneNumber: user.phoneNumber,
      department: user.department,
      permissions: user.permissions,
      isActive: user.isActive,
      lastLogin: user.lastLogin,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
