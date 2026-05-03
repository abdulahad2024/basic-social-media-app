import 'package:http/http.dart' as http;
import '../../../../export.dart';

class UserProfileServices {
  final AuthSession authSession = AuthSession();

  Future<http.Response?> otherUserProfile(String id) async {
    final String? token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.otherUserProfile(id));

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
print(response.body);
      return response;
    } catch (e) {
      print("Parsing Error: $e");
    }
    return null;
  }


    Future<http.Response?> userFriendsList(String id) async {
    final String? token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.userFriendsList(id));

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      print("Parsing Error: $e");
    }
    return null;
  }




  Future<http.Response?> unFriends(String id) async {
    final String? token = await authSession.getToken();

    try {
      final url = Uri.parse(ApiUrl.unfriend);
      final body = {
        "friend_id": id,
      };


      final response = await http.post(
        url,
        body: body,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      print("Parsing Error: $e");
    }
    return null;
  }






}
