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
      this.image =
          "https://i.pinimg.com/564x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg",
      this.cover =
          "https://i.pinimg.com/564x/65/42/86/6542867f9f6907563dcd4e9756fa5027.jpg",
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
