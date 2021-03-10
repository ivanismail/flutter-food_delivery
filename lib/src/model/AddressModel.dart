import 'dart:convert';
import 'package:http/http.dart' as http;

List<AddressModel> addressFromJson(String str) {
  final jsonData = jsonDecode(str);
  return List<AddressModel>.from(jsonData.map((x) => AddressModel.fromJson(x)));
}

class AddressModel {
  String id;
  String title;

  AddressModel({
    this.id,
    this.title,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}

class User {
  String id;
  String title;

  User({this.id, this.title});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'].toString(),
      title: object['title'],
    );
  }
  static Future<List<User>> getUsers(String page) async {
    String apiURL =
        "https://revgeocode.search.hereapi.com/v1/revgeocode?apiKey=7_KPQb0dn8oOrxdDqtwfZSypnGze5kFMZFxpv6DThPY&at=" +
            page;

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['items'];

    List<User> users = [];
    for (int i = 0; i < listUser.length; i++)
      users.add(User.createUser(listUser[i]));

    return users;
  }
}
