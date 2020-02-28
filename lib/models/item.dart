class Item {
  final String id;
  final String title;
  final String body;
  final String url;
  final User user;

  Item({
    this.id,
    this.title,
    this.body,
    this.url,
    this.user,
  });

  static Item fromJson(dynamic json) {
    return Item(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      url: json['url'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String profileImageUrl;

  User({
    this.profileImageUrl,
  });

  static User fromJson(dynamic json) {
    return User(
      profileImageUrl: json['profile_image_url'],
    );
  }
}

