import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_movies_app/data/model/user_data.dart';

class FirestoreUserService {
  final _userRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserData>(
        fromFirestore: (snapshots, _) => UserData.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future addUser(UserData user) async {
    await _userRef.doc(user.userId).set(user);
  }
}
