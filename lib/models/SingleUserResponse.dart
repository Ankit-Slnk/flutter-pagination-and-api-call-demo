import 'UsersResponse.dart';

class SingleUserResponse {
  UserDetails data;

  SingleUserResponse({
    this.data,
  });

  SingleUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
