import 'package:flutter/material.dart';

import 'package:flutterPaginationApi/widgets/userEmailView.dart';
import 'package:flutterPaginationApi/widgets/userImageView.dart';
import 'package:flutterPaginationApi/widgets/userNameView.dart';

import '../models/UsersResponse.dart';

class UserItemView extends StatelessWidget {
  UserDetails userDetails;
  Function() onTap;
  Function() onImageTap;
  UserItemView({
    @required this.userDetails,
    @required this.onTap,
    @required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: UserImageView(
        userDetails: userDetails,
        onImageTap: onImageTap,
        isDetailScreen: false,
      ),
      title: UserNameView(
        userDetails: userDetails,
        isDetailScreen: false,
      ),
      subtitle: UserEmailView(
        userDetails: userDetails,
        isDetailScreen: false,
      ),
    );
  }
}
