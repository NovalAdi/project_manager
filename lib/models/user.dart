class User {
  final int? id;
  final String? username;
  final String? nickname;
  final String? image;
  final String? email;
  final String? updatedAt;
  final String? createdAt;

  User({
    this.id,
    this.username,
    this.nickname,
    this.image,
    this.email,
    this.updatedAt,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      nickname: json['nickname'],
      image: json['image'],
      email: json['email'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['nickname'] = nickname;
    data['image'] = image;
    data['email'] = email;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
