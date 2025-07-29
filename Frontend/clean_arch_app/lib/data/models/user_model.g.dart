// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  phoneNumber: json['phoneNumber'] as String?,
  department: json['department'] as String?,
  permissions: (json['permissions'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$PermissionTypeEnumMap, e))
      .toList(),
  isActive: json['isActive'] as bool? ?? true,
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role]!,
  'phoneNumber': instance.phoneNumber,
  'department': instance.department,
  'permissions': instance.permissions
      .map((e) => _$PermissionTypeEnumMap[e]!)
      .toList(),
  'isActive': instance.isActive,
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.manager: 'manager',
  UserRole.supervisor: 'supervisor',
  UserRole.staff: 'staff',
  UserRole.viewer: 'viewer',
};

const _$PermissionTypeEnumMap = {
  PermissionType.viewProducts: 'viewProducts',
  PermissionType.createProduct: 'createProduct',
  PermissionType.editProduct: 'editProduct',
  PermissionType.deleteProduct: 'deleteProduct',
  PermissionType.adjustStock: 'adjustStock',
  PermissionType.viewSuppliers: 'viewSuppliers',
  PermissionType.createSupplier: 'createSupplier',
  PermissionType.editSupplier: 'editSupplier',
  PermissionType.deleteSupplier: 'deleteSupplier',
  PermissionType.viewUsers: 'viewUsers',
  PermissionType.createUser: 'createUser',
  PermissionType.editUser: 'editUser',
  PermissionType.deleteUser: 'deleteUser',
  PermissionType.manageRoles: 'manageRoles',
  PermissionType.viewStockTakes: 'viewStockTakes',
  PermissionType.createStockTake: 'createStockTake',
  PermissionType.performStockTake: 'performStockTake',
  PermissionType.approveStockTake: 'approveStockTake',
  PermissionType.viewReports: 'viewReports',
  PermissionType.generateReports: 'generateReports',
  PermissionType.exportReports: 'exportReports',
  PermissionType.viewActivityLog: 'viewActivityLog',
  PermissionType.viewAllActivities: 'viewAllActivities',
  PermissionType.manageSettings: 'manageSettings',
  PermissionType.backupData: 'backupData',
  PermissionType.restoreData: 'restoreData',
  PermissionType.systemMaintenance: 'systemMaintenance',
};
