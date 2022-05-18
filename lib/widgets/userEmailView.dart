import 'package:flutter/material.dart';

import '../models/UsersResponse.dart';
import '../utility/appColors.dart';

class UserEmailView extends StatelessWidget {
  UserDetails userDetails;
  bool isDetailScreen;
  UserEmailView({
    @required this.userDetails,
    @required this.isDetailScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      userDetails?.email == null ? "" : userDetails.email,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }
}
