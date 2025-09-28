import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:student_list/constants.dart';
import 'package:student_list/models/user.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<User>> getUsers() async {
    try {
      Response response = await dio.get("/users");
      //i know this is list
      List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      throw Exception('failed to load users: $e');
    }
  }

  Future<User> createUser(String name, String city) async {
    try {
      Response response = await dio.post(
        "/users",
        //map
        data: {"name": name, "city": city},
      );
      //because i Know this is one item we send
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception("failed to create user: $e");
    }
  }

  Future<User> updateUser(String id, String name, String city) async {
    try {
      Response response = await dio.put(
        "/users/$id",
        data: {'name': name, 'city': city},
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception("failed to update user: $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await dio.delete("/users/$id");
    } catch (e) {
      throw Exception('failed to delete user: $e');
    }
  }
}
