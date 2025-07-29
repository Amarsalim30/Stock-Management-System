import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_view_model.dart';
import 'widgets/user_item_card.dart';
import 'widgets/user_form_dialog.dart';
import '../../domain/entities/user.dart';

// Example of using the refactored UserViewModel with Riverpod
class UserManagementPageExample extends ConsumerStatefulWidget {
  const UserManagementPageExample({Key? key}) : super(key: key);

  @override
  ConsumerState<UserManagementPageExample> createState() =>
      _UserManagementPageExampleState();
}

class _UserManagementPageExampleState
    extends ConsumerState<UserManagementPageExample> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the page loads
    Future.microtask(() {
      ref.read(userViewModelProvider.notifier).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final userViewModel = ref.read(userViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newUser = await showDialog<User>(
                context: context,
                builder: (context) => UserFormDialog(),
              );
              if (newUser != null) {
                userViewModel.addUser(newUser);
              }
            },
          ),
        ],
      ),
      body: userState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${userState.error}'),
                  ElevatedButton(
                    onPressed: () {
                      userViewModel.clearError();
                      userViewModel.fetchUsers();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: userState.users.length,
              itemBuilder: (context, index) {
                return UserItemCard(
                  user: userState.users[index],
                  onEdit: (user) => userViewModel.updateUser(user),
                  onDelete: (id) => userViewModel.deleteUser(id),
                  onToggleActivation: (id) =>
                      userViewModel.toggleUserActivation(id),
                );
              },
            ),
    );
  }
}

// Alternative approach using Consumer widget
class UserManagementPageAlternative extends StatelessWidget {
  const UserManagementPageAlternative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final newUser = await showDialog<User>(
                    context: context,
                    builder: (context) => UserFormDialog(),
                  );
                  if (newUser != null) {
                    ref.read(userViewModelProvider.notifier).addUser(newUser);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userState = ref.watch(userViewModelProvider);
          final userViewModel = ref.read(userViewModelProvider.notifier);

          // Initial fetch
          if (userState.users.isEmpty &&
              !userState.isLoading &&
              userState.error == null) {
            Future.microtask(() => userViewModel.fetchUsers());
          }

          if (userState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${userState.error}'),
                  ElevatedButton(
                    onPressed: () {
                      userViewModel.clearError();
                      userViewModel.fetchUsers();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: userState.users.length,
            itemBuilder: (context, index) {
              return UserItemCard(
                user: userState.users[index],
                onEdit: (user) => userViewModel.updateUser(user),
                onDelete: (id) => userViewModel.deleteUser(id),
                onToggleActivation: (id) =>
                    userViewModel.toggleUserActivation(id),
              );
            },
          );
        },
      ),
    );
  }
}
