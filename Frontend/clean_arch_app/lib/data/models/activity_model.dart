import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/activity.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Activity {
  const ActivityModel({
    required String id,
    required String userId,
    required String userName,
    required ActivityType type,
    required String action,
    String? description,
    Map<String, dynamic>? metadata,
    required DateTime timestamp,
    String? ipAddress,
    String? deviceInfo,
  }) : super(
         id: id,
         userId: userId,
         userName: userName,
         type: type,
         action: action,
         description: description,
         metadata: metadata,
         timestamp: timestamp,
         ipAddress: ipAddress,
         deviceInfo: deviceInfo,
       );

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  // Helper method to convert from entity to model
  factory ActivityModel.fromEntity(Activity activity) {
    return ActivityModel(
      id: activity.id,
      userId: activity.userId,
      userName: activity.userName,
      type: activity.type,
      action: activity.action,
      description: activity.description,
      metadata: activity.metadata,
      timestamp: activity.timestamp,
      ipAddress: activity.ipAddress,
      deviceInfo: activity.deviceInfo,
    );
  }

  static activityTypeToString(ActivityType type) {}
}
