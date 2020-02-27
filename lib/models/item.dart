import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemModel extends ChangeNotifier {
  List<Item> get items => _items;

  List<Item> _items = [];

  void search(String query) async {
    final http.Response res =
        await http.get("https://qiita.com//api/v2/items?query=$query");
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final itemsJson = json.decode(res.body) as List;
    _items = itemsJson.map((data) => Item.fromJson(data)).toList();
    notifyListeners();
  }
}

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

class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message) : assert(code != null);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}
