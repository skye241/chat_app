part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthShowLoading extends AuthState {}

class AuthSuccess extends AuthState {


}
