import 'dart:convert';
import 'package:http/http.dart' as http;

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

  // static Future<User> connectToAPI(String id) async {
  //   String apiURL = "https://reqres.in/api/users/" + id;
  //
  //   var apiResult = await http.get(apiURL);
  //   var jsonObject = json.decode(apiResult.body);
  //   var userData = (jsonObject as Map<String, dynamic>)['data'];
  //
  //   return User.createUser(userData);
  // }

  static Future<List<User>> getUsers(String page) async {
    String apiURL =
        "https://revgeocode.search.hereapi.com/v1/revgeocode?apiKey=7_KPQb0dn8oOrxdDqtwfZSypnGze5kFMZFxpv6DThPY&at=" +
            page;

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    //var userData = (jsonObject as List<String, dynamic>)['data'];
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['items'];

    List<User> users = [];
    for (int i = 0; i < listUser.length; i++)
      users.add(User.createUser(listUser[i]));

    return users;
  }
}
