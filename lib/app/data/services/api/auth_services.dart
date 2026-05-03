import 'dart:convert';
import 'dart:io'; // এটি অবশ্যই যোগ করবেন SocketException ও HandshakeException এর জন্য
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_url/api_url.dart';
import '../network/network_utils.dart';
import '../seassion/auth_seassion.dart';

class AuthServices {
  final AuthSession authSession = AuthSession();

  Future<http.Response?> login(Map<String, dynamic> data) async {
    if (!await NetworkUtils.hasInternet()) {
      return null;
    }

    try {
      final url = Uri.parse(ApiUrl.login);

      final body = jsonEncode(data);

      final response = await http
          .post(
            url,
            body: body,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on HandshakeException catch (e) {
      debugPrint("Handshake Error: $e");
      return null;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return null;
    } catch (e) {
      debugPrint("AuthServices General Error: ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> sendOtp(Map<String, dynamic> data) async {
    if (!await NetworkUtils.hasInternet()) {
      return null;
    }

    try {
      final url = Uri.parse(ApiUrl.sendOtp);
      final body = jsonEncode(data);

      final response = await http
          .post(
            url,
            body: body,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on HandshakeException catch (e) {
      debugPrint("Handshake Error: $e");
      return null;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return null;
    } catch (e) {
      debugPrint("AuthServices General Error: ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> verifyOtp(Map<String, dynamic> data) async {
    if (!await NetworkUtils.hasInternet()) {
      return null;
    }

    try {
      final url = Uri.parse(ApiUrl.verifyOtp);
      final body = jsonEncode(data);

      final response = await http
          .post(
            url,
            body: body,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on HandshakeException catch (e) {
      debugPrint("Handshake Error: $e");
      return null;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return null;
    } catch (e) {
      debugPrint("AuthServices General Error: ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> personalInfo(Map<String, dynamic> data) async {
    final token = await authSession.getToken();
    print("Token: $token");

    if (!await NetworkUtils.hasInternet()) {
      return null;
    }

    try {
      final url = Uri.parse(ApiUrl.completeProfile);
      final body = jsonEncode(data);

      final response = await http
          .post(
            url,
            body: body,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on HandshakeException catch (e) {
      debugPrint("Handshake Error: $e");
      return null;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return null;
    } catch (e) {
      debugPrint("AuthServices General Error: ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> createPhoto(Map<String, dynamic> data) async {
    final token = await authSession.getToken();
    if (!await NetworkUtils.hasInternet()) return null;

    try {
      final url = Uri.parse(ApiUrl.uploadImage);
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.files.add(
        await http.MultipartFile.fromPath('image', data['image']),
      );
      request.files.add(
        await http.MultipartFile.fromPath('cover', data['cover']),
      );

      final response = await request.send().timeout(
        const Duration(seconds: 30),
      );
      return await http.Response.fromStream(response);
    } catch (e) {
      debugPrint("Multipart Error: $e");
      return null;
    }
  }

  Future<http.Response?> resendOtp(Map<String, dynamic> data) async {
    if (!await NetworkUtils.hasInternet()) {
      return null;
    }

    try {
      final url = Uri.parse(ApiUrl.resendOtp);
      final body = jsonEncode(data);

      final response = await http
          .post(
            url,
            body: body,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on HandshakeException catch (e) {
      debugPrint("Handshake Error: $e");
      return null;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return null;
    } catch (e) {
      debugPrint("AuthServices General Error: ${e.toString()}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final token = await authSession.getToken();
    final url = Uri.parse(ApiUrl.userProfile);

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint("Get Profile Error: $e");
    }
    return null;
  }

  Future<http.Response?> editProfile(Map<String, dynamic> data) async {
    final token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.updateProfile);
      final request = http.MultipartRequest("POST", url);

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields.addAll({
        "name": data['name']?.toString() ?? "",
        "about": data['about']?.toString() ?? "",
        "education": data['education']?.toString() ?? "",
        "address": data['address']?.toString() ?? "",
        "gender": data['gender']?.toString() ?? "",
        "dob": data['dob']?.toString() ?? "",
      });

      if (data['image'] != null && data['image'] is File && (data['image'] as File).path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            (data['image'] as File).path,
          ),
        );
      }

      if (data['cover'] != null && data['cover'] is File && (data['cover'] as File).path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'cover',
            (data['cover'] as File).path,
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      debugPrint("Edit Profile Error: $e");
      return null;
    }
  }






}
