import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/common/session/session_pref.dart';
import 'package:dulichquangninh/providers/models/user.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  User _user;

  User get user => _user;

  void checkAuth() {
    final user = SessionPref.getUser();
    _user = user;
    emit(AuthLoaded(_user));
  }

  void signIn(User user) {
    SessionPref.saveSession(user);
    _user = user;
    emit(AuthLoaded(_user));
  }

  void signOut() {
    SessionPref.clearUserData();
    _user = null;
    emit(AuthLoaded(_user));
  }
}
