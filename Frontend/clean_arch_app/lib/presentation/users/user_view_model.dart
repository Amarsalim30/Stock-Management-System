import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';

class UserState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  UserState({this.users = const [], this.isLoading = false, this.error});

  UserState copyWith({List<User>? users, bool? isLoading, String? error}) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UserViewModel extends StateNotifier<UserState> {
  UserViewModel() : super(UserState());

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      final users = [
        User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          role: UserRole.admin,
          department: 'IT',
          createdAt: DateTime.now().subtract(Duration(days: 365)),
        ),
        User(
          id: '2',
          name: 'Jane Doe',
          email: 'jane@example.com',
          role: UserRole.staff,
          department: 'Sales',
          createdAt: DateTime.now().subtract(Duration(days: 180)),
        ),
      ];
      state = state.copyWith(users: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch users: ${e.toString()}',
      );
    }
  }

  void addUser(User user) {
    final updatedUsers = [...state.users, user];
    state = state.copyWith(users: updatedUsers);
  }

  void updateUser(User user) {
    final index = state.users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      final updatedUsers = [...state.users];
      updatedUsers[index] = user;
      state = state.copyWith(users: updatedUsers);
    }
  }

  void deleteUser(String id) {
    final updatedUsers = state.users.where((user) => user.id != id).toList();
    state = state.copyWith(users: updatedUsers);
  }

  void toggleUserActivation(String id) {
    final index = state.users.indexWhere((user) => user.id == id);
    if (index != -1) {
      final user = state.users[index];
      final updatedUser = User(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        phoneNumber: user.phoneNumber,
        department: user.department,
        permissions: user.permissions,
        isActive: !user.isActive,
        lastLogin: user.lastLogin,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );
      final updatedUsers = [...state.users];
      updatedUsers[index] = updatedUser;
      state = state.copyWith(users: updatedUsers);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider definition
final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>((
  ref,
) {
  return UserViewModel();
});
