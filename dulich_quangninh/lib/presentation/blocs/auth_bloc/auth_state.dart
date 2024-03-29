part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final User user;

  AuthLoaded(this.user);

  @override
  List<Object> get props => [user];
}


