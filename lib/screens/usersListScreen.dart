import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/models/UsersResponse.dart';
import 'package:flutterPaginationApi/utility/apiManager.dart';
import 'package:flutterPaginationApi/utility/appAssets.dart';
import 'package:flutterPaginationApi/utility/appColors.dart';
import 'package:flutterPaginationApi/utility/appStrings.dart';
import 'package:flutterPaginationApi/utility/utiity.dart';
import 'package:visibility_detector/visibility_detector.dart';

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<UserDetails> userDetails = List();
  int page = 0;
  int valueKey = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;
  bool stop = false;

  getUsers() async {
    if (await ApiManager.checkInternet()) {
      if (mounted)
        setState(() {
          isLoading = true;
        });

      page = page + 1;
      var request = Map<String, dynamic>();
      request["page"] = page.toString();

      UsersResponse response = UsersResponse.fromJson(
        await ApiManager(context).getCall(
          AppStrings.USERS,
          request,
        ),
      );

      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (response != null) {
        if (response.data.length > 0) {
          if (mounted) {
            setState(() {
              userDetails.addAll(response.data);
            });
          }
        } else {
          nodatalogic(page);
        }
      } else {
        nodatalogic(page);
      }
    } else {
      Utility.showToast("No Internet Connection");
    }
  }

  nodatalogic(int pagenum) {
    if (mounted) {
      setState(() {
        page = pagenum - 1;
        stop = true;
      });
    }
  }

  refresh() {
    if (mounted)
      setState(() {
        valueKey = valueKey + 1;
        page = 0;
        userDetails.clear();
        stop = false;
      });
    getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        refresh();
      },
      child: !isLoading && userDetails.length == 0
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      ((AppBar().preferredSize.height * 2) + 30),
                  child: Utility.emptyView("No Users"),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: 12,
              ),
              itemCount: userDetails.length,
              itemBuilder: (BuildContext context, int index) {
                return (userDetails.length - 1) == index
                    ? VisibilityDetector(
                        key: Key(index.toString()),
                        child: itemView(index),
                        onVisibilityChanged: (visibilityInfo) {
                          if (!stop) {
                            getUsers();
                          }
                        },
                      )
                    : itemView(index);
              },
            ),
    );
  }

  Widget itemView(int index) {
    return ListTile(
      leading: ClipRRect(
        child: Utility.imageLoader(
          userDetails[index].avatar,
          AppAssets.imagePlaceholder,
        ),
      ),
      title: Text(
        userDetails[index].firstName + " " + userDetails[index].lastName,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.blackColor,
        ),
      ),
      subtitle: Text(
        userDetails[index].email,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
