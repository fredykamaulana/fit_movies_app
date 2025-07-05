import 'package:fit_movies_app/data/firestore/firestore_user_service.dart';
import 'package:fit_movies_app/data/model/user_data.dart';

class UserController {
  final FirestoreUserService _userService;

  UserController(this._userService);

  Future addUser(UserData user) async {
    await _userService.addUser(user);
  }
}
