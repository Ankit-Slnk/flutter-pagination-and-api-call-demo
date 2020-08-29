import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/models/SingleUserResponse.dart';
import 'package:flutterPaginationApi/models/UsersResponse.dart';
import 'package:flutterPaginationApi/utility/apiManager.dart';
import 'package:flutterPaginationApi/utility/appAssets.dart';
import 'package:flutterPaginationApi/utility/appColors.dart';
import 'package:flutterPaginationApi/utility/appStrings.dart';
import 'package:flutterPaginationApi/utility/utiity.dart';

class UserDetailScreen extends StatefulWidget {
  int id;
  UserDetailScreen({@required this.id});
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isLoading = false;
  UserDetails userDetails = UserDetails();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    //first check for internet connectivity
    if (await ApiManager.checkInternet()) {
      //show progress
      if (mounted)
        setState(() {
          isLoading = true;
        });

      //convert json response to class
      SingleUserResponse response = SingleUserResponse.fromJson(
        await ApiManager(context).getCall(
          url: AppStrings.USERS + "/" + widget.id.toString(),
          request: null,
        ),
      );

      //hide progress
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (response?.data != null) {
        if (mounted) {
          setState(() {
            userDetails = response.data;
          });
        }
      }
    } else {
      //if no internet connectivity available then show apecific message
      Utility.showToast("No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Detail",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: itemView(),
    );
  }

  Widget itemView() {
    //users item view
    return Stack(
      children: <Widget>[
        userDetails == null
            ? Container()
            : ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Utility.imageLoader(
                      userDetails.avatar,
                      AppAssets.imagePlaceholder,
                    ),
                  ),
                ),
                title: Text(
                  (userDetails?.firstName == null
                          ? ""
                          : userDetails.firstName) +
                      " " +
                      (userDetails?.lastName == null
                          ? ""
                          : userDetails.lastName),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.blackColor,
                  ),
                ),
                subtitle: Text(
                  userDetails?.email == null ? "" : userDetails.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
        isLoading ? Utility.progress(context) : Container()
      ],
    );
  }
}
