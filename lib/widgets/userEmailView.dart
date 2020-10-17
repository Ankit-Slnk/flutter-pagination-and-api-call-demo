import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/utility/appDimens.dart';

import '../models/UsersResponse.dart';
import '../utility/appColors.dart';

class UserEmailView extends StatelessWidget {
  UserDetails userDetails;
  bool isDetailScreen;
  UserEmailView({
    @required this.userDetails,
    @required this.isDetailScreen,
  });

  AppDimens appDimens;

  @override
  Widget build(BuildContext context) {
    appDimens = new AppDimens(MediaQuery.of(context).size);

    return Text(
      userDetails?.email == null ? "" : userDetails.email,
      style: TextStyle(
        fontSize: appDimens.text16,
        color: AppColors.greyColor,
      ),
    );
  }
}
