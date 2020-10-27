import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/screens/user/userDetailScreen.dart';
import 'package:flutterPaginationApi/screens/user/usersListScreen.dart';
import 'package:flutterPaginationApi/utility/utiity.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Utility.isNotMobileAndLandscape(context)) {
      return Row(
        children: [
          Expanded(
            child: UsersListScreen(),
          ),
          Expanded(
            child: UserDetailScreen(
              selectedUserId: null,
            ),
          ),
        ],
      );
    }
    return UsersListScreen();
  }
}
