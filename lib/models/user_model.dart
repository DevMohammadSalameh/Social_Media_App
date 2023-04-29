class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isVerified;

  UserModel(this.name, this.email, this.phone, this.uId, this.isVerified);

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isVerified': isVerified,
    };
  }
}
