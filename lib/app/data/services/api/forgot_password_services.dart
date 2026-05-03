
import 'package:social_media_app/export.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordServices {

  Future<http.Response?> forgotPassword(String email) async {
    try {
      final url = Uri.parse(ApiUrl.forgotPassword);

      final body = jsonEncode({
        'email': email,
      });

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint("Forgot Password Response: ${response.body}");

      if (response.statusCode == 200) {
        return response;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['messages'] ?? "Failed to send OTP!");
      }

    } catch (e) {
      debugPrint("Forgot Password Error: $e");
      rethrow;
    }
  }




  Future<http.Response?> verifyResetOtp(String email, String otp) async {
    try {
      final url = Uri.parse(ApiUrl.verifyResetOtp);
      final body = jsonEncode({
        'email': email,
        'otp': otp,
      });

      return await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response?> resendOtp(String email) async {
    try {
      final url = Uri.parse(ApiUrl.resendForgotPasswordOtp);
      final body = jsonEncode({'email': email});

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      debugPrint("Resend OTP Error: $e");
      rethrow;
    }
  }


  Future<http.Response?> resetPassword(Map<String, dynamic> data) async {
    try {

      final url = Uri.parse(ApiUrl.resetPassword);
      final body = jsonEncode(data);

      return await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

    } catch (e) {
      rethrow;
    }
  }



}