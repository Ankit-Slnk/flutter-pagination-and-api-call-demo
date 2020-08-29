/*

JSON api response converted to dart class from - https://javiercbk.github.io/json_to_dart/

*/

class UsersResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserDetails> data;

  UsersResponse({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  UsersResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = new List<UserDetails>();
      json['data'].forEach((v) {
        data.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetails {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  UserDetails(
      {this.id, this.email, this.firstName, this.lastName, this.avatar});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    email = json['email'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    avatar = json['avatar'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}
