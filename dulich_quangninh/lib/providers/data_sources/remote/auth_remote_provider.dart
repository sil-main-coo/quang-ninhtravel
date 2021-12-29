import 'package:dulichquangninh/common/error/remote_exception.dart';
import 'package:dulichquangninh/providers/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthRemoteProvider {
  final refUsersDB = FirebaseDatabase.instance.reference().child('users');

  Future<User> signIn(User account) async {
    User user;

    try {
      final authUserName = await getUserByPhone(account.phone);

      if (authUserName.value != null) {
        final mapUser = Map<String, dynamic>.from(authUserName.value);

        mapUser.forEach((uid, data) {
          final Map<String, dynamic> uData = Map<String, dynamic>.from(data);

          if (uData['password'] == account.password) {
            // match pwd
            user = User.fromJson(uData, uid);
          }
        });
        if (user != null) {
          return user;
        }
      }
      throw RemoteException('Sai tài khoản hoặc mật khẩu');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DataSnapshot> getUserByPhone(String phone) async {
    try {
      return await refUsersDB.orderByChild('phone').equalTo(phone).once();
    } catch (e) {
      throw RemoteException('Đã xảy ra lỗi');
    }
  }

  Future<User> signUp(User model) async {
    try {
      final authUserName = await getUserByPhone(model.phone);
      print(authUserName.value);
      if (authUserName.value != null) throw RemoteException('Số điện thoại đã được đăng ký');

      final uid = refUsersDB.push();
      model.profile?.id = uid.key;
      await uid.set(model.toJson());
      return model;
    } on RemoteException catch (e) {
      print(e);
      throw e.toString();
    } catch (e) {
      print(e);
      throw RemoteException('Đăng ký không thành công. Vui lòng thử lại!');
    }
  }

  Future<void> updateUserOnDB(String id, Map<String, dynamic> data) async {
    try {
      return await refUsersDB.child(id).update(data);
    } catch (e) {}
    throw RemoteException('Cập nhật user thất bại');
  }

  Future<void> updateUseProfileOnDB(
      String id, Map<String, dynamic> data) async {
    try {
      return await refUsersDB.child(id).child('profile').update(data);
    } catch (e) {}
    throw RemoteException('Cập nhật user thất bại');
  }

  Future<void> removeUser(String id) async {
    print(id);
    try {
      return await refUsersDB.child(id).remove();
    } catch (e) {
      print(e);
    }
    throw RemoteException('Xóa user thất bại');
  }
}
