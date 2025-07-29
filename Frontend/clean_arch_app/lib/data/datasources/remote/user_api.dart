import '../../../core/network/api_client.dart';
import '../../models/user_model.dart';

abstract class UserApi {
  Future<List<UserModel>> getUsers({
    int? page,
    int? limit,
    String? search,
    String? role,
    bool? isActive,
  });

  Future<UserModel> getUserById(String userId);

  Future<UserModel> createUser(Map<String, dynamic> userData);

  Future<UserModel> updateUser(String userId, Map<String, dynamic> userData);

  Future<void> deleteUser(String userId);

  Future<void> activateUser(String userId);

  Future<void> deactivateUser(String userId);

  Future<void> updateUserRole(String userId, String role);

  Future<void> updateUserPermissions(String userId, List<String> permissions);

  Future<Map<String, dynamic>> getUserStats();
}

class UserApiImpl implements UserApi {
  final ApiClient _apiClient;

  UserApiImpl(this._apiClient);

  @override
  Future<List<UserModel>> getUsers({
    int? page,
    int? limit,
    String? search,
    String? role,
    bool? isActive,
  }) async {
    final queryParams = <String, dynamic>{};
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;
    if (search != null && search.isNotEmpty) queryParams['search'] = search;
    if (role != null && role.isNotEmpty) queryParams['role'] = role;
    if (isActive != null) queryParams['isActive'] = isActive;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/users',
      queryParameters: queryParams,
    );

    final users = response['data'] as List;
    return users.map((json) => UserModel.fromJson(json)).toList();
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/users/$userId',
    );
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> createUser(Map<String, dynamic> userData) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/users',
      data: userData,
    );
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> updateUser(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    final response = await _apiClient.put<Map<String, dynamic>>(
      '/users/$userId',
      data: userData,
    );
    return UserModel.fromJson(response);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _apiClient.delete('/users/$userId');
  }

  @override
  Future<void> activateUser(String userId) async {
    await _apiClient.put('/users/$userId/activate');
  }

  @override
  Future<void> deactivateUser(String userId) async {
    await _apiClient.put('/users/$userId/deactivate');
  }

  @override
  Future<void> updateUserRole(String userId, String role) async {
    await _apiClient.put('/users/$userId/role', data: {'role': role});
  }

  @override
  Future<void> updateUserPermissions(
    String userId,
    List<String> permissions,
  ) async {
    await _apiClient.put(
      '/users/$userId/permissions',
      data: {'permissions': permissions},
    );
  }

  @override
  Future<Map<String, dynamic>> getUserStats() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/users/stats');
    return response;
  }
}
