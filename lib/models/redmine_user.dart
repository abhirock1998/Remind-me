class RedmineUser {
  User? user;

  RedmineUser({this.user});

  RedmineUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? login;
  bool? admin;
  String? firstname;
  String? lastname;
  String? mail;
  String? createdOn;
  String? lastLoginOn;
  String? apiKey;
  String? avatar;
  List<CustomFields>? customFields;

  User({
    this.id,
    this.login,
    this.admin,
    this.firstname,
    this.lastname,
    this.mail,
    this.createdOn,
    this.lastLoginOn,
    this.apiKey,
    this.customFields,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    admin = json['admin'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    avatar = json["avatar"];
    mail = json['mail'];
    createdOn = json['created_on'];
    lastLoginOn = json['last_login_on'];
    apiKey = json['api_key'];
    if (json['custom_fields'] != null) {
      customFields = <CustomFields>[];
      json['custom_fields'].forEach((v) {
        customFields!.add(CustomFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    data['admin'] = admin;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['mail'] = mail;
    data['created_on'] = createdOn;
    data['last_login_on'] = lastLoginOn;
    data['api_key'] = apiKey;
    data['avatar'] = avatar;
    if (customFields != null) {
      data['custom_fields'] = customFields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomFields {
  int? id;
  String? name;
  String? value;

  CustomFields({this.id, this.name, this.value});

  CustomFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
