class UserModel {
  late String name;
  late String email;
  late String phone;
  late String image;
  late String cover;
  late String bio;
  late String uId;
  late bool isVerified;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isVerified,
      required this.image,
      required this.cover,
      required this.bio});

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    phone = json['phone'];
    uId = json['uId'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'cover': cover,
      'bio': bio,
      'phone': phone,
      'uId': uId,
      'isVerified': isVerified,
    };
  }
}
