class UserModel {
  String? uid;
  String? name;
  String? email;
  String? role;
  String? picture;

  UserModel({
    this.email,
    this.name,
    this.picture,
    this.role,
    this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'picture': picture,
      'role': role,
      'uid': uid,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    picture = json['picture'];
    role = json['role'];
    uid = json['uid'];
  }
}
