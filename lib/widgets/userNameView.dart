import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/utility/appDimens.dart';

import '../models/UsersResponse.dart';
import '../utility/appColors.dart';

class UserNameView extends StatelessWidget {
  UserDetails userDetails;
  bool isDetailScreen;
  UserNameView({
    @required this.userDetails,
    @required this.isDetailScreen,
  });

  AppDimens appDimens;

  @override
  Widget build(BuildContext context) {
    appDimens = new AppDimens(MediaQuery.of(context).size);

    return Text(
      userDetails?.firstName == null
          ? ""
          : userDetails.firstName + " " + userDetails.lastName,
      style: TextStyle(
        fontSize: isDetailScreen ? appDimens.text20 : appDimens.text18,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
