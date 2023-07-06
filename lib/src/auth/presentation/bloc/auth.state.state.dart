part of 'auth.state.bloc.dart';

abstract class AuthStateState extends Equatable {
  const AuthStateState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthStateState {}

class CodeSentAuthState extends AuthStateState {
  final String verificationId;
  final int? resendToken;
  const CodeSentAuthState({required this.verificationId, this.resendToken});
}

class NotVerifiedAuthState extends AuthStateState {}

class VerifiyingAuthState extends AuthStateState {}

class ConfirmingAuthState extends AuthStateState {}

class VerificationFailedAuthState extends AuthStateState {
  final Failure failure;
  const VerificationFailedAuthState({required this.failure});
}

class ConfirmationFailedAuthState extends AuthStateState {
  final Failure failure;
  const ConfirmationFailedAuthState({required this.failure});
}

class VerifiedAuthState extends AuthStateState {
  final PhoneAuthCredential phoneAuthCredential;
  const VerifiedAuthState({required this.phoneAuthCredential});
}

class ConfirmedAuthState extends AuthStateState {
  final User user;
  const ConfirmedAuthState({required this.user});
}
