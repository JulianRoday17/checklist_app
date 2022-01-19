import 'package:checklist_app/services/network_dio.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future login(username, password);
  Future register(email, username, password);
  Future getAllData(token);
  Future addData(text, token);
}

class AuthServices extends AuthRepository {
  Dio get _dio => NetworkDio.createDio();

  Future login(username, password) async {
    try {
      Response response = await _dio.post(
        "/login",
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future register(email, username, password) async {
    try {
      Response response = await _dio.post(
        "/register",
        data: {
          'email': email,
          'username': username,
          'password': password,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future addData(text, token) async {
    try {
      Response response = await _dio.post(
        "/checklist",
        data: {
          'name': text,
        },
        options: Options(headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer $token'
        }),
      );

      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future getAllData(token) async {
    try {
      Response response = await _dio.get(
        "/checklist",
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}
