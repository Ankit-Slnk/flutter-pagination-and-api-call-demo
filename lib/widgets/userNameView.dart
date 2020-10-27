import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../models/UsersResponse.dart';
import '../utility/appColors.dart';

class UserNameView extends StatelessWidget {
  UserDetails userDetails;
  bool isDetailScreen;
  UserNameView({
    @required this.userDetails,
    @required this.isDetailScreen,
  });

  @override
  Widget build(BuildContext context) {
    String name = userDetails?.firstName == null
        ? ""
        : userDetails.firstName + " " + userDetails.lastName;
    return name.text
        .size(isDetailScreen ? 20 : 18)
        .textStyle(
          TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        )
        .make();
  }
}
