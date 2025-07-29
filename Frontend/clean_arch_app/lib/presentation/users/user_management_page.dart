import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import 'user_view_model.dart';
import 'widgets/user_item_card.dart';
import 'widgets/user_form_dialog.dart';

class UserManagementPage extends StatelessWidget {
  final UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newUser = await showDialog(
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
      body: FutureBuilder<List<User>>(
        future: userViewModel.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserItemCard(
                  user: users[index],
                  userViewModel: userViewModel,
                );
              },
            );
          }
        },
      ),
    );
  }
}
