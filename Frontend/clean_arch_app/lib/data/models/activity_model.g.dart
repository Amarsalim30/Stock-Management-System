// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      action: json['action'] as String,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      ipAddress: json['ipAddress'] as String?,
      deviceInfo: json['deviceInfo'] as String?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'action': instance.action,
      'description': instance.description,
      'metadata': instance.metadata,
      'timestamp': instance.timestamp.toIso8601String(),
      'ipAddress': instance.ipAddress,
      'deviceInfo': instance.deviceInfo,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.login: 'login',
  ActivityType.logout: 'logout',
  ActivityType.productCreated: 'productCreated',
  ActivityType.productUpdated: 'productUpdated',
  ActivityType.productDeleted: 'productDeleted',
  ActivityType.stockAdjusted: 'stockAdjusted',
  ActivityType.stockTakeStarted: 'stockTakeStarted',
  ActivityType.stockTakeCompleted: 'stockTakeCompleted',
  ActivityType.supplierCreated: 'supplierCreated',
  ActivityType.supplierUpdated: 'supplierUpdated',
  ActivityType.supplierDeleted: 'supplierDeleted',
  ActivityType.userCreated: 'userCreated',
  ActivityType.userUpdated: 'userUpdated',
  ActivityType.userDeleted: 'userDeleted',
  ActivityType.reportGenerated: 'reportGenerated',
  ActivityType.settingsChanged: 'settingsChanged',
};
