import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/models/users_response.dart';
import 'package:realtime_chat/service/auth_service.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final uri = Uri.http(Enviroment.apiUrl, '/api/users');
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });
      final data = usersResponseFromJson(response.body);
      return data.users;
    } catch (e) {
      return [];
    }
  }
}
