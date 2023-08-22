part of 'auth.state.bloc.dart';

abstract class AuthStateEvent extends Equatable {
  const AuthStateEvent();

  @override
  List<Object> get props => [];
}

class OnSignInEvent extends AuthStateEvent {
  final User user;
  const OnSignInEvent({required this.user});
}

class OnAuthInitialEvent extends AuthStateEvent {}

class OnVerficationComplete extends AuthStateEvent {
  final PhoneAuthCredential credential;
  const OnVerficationComplete({required this.credential});
}

class OnCodeSent extends AuthStateEvent {
  final String verificationId;
  final int? resendToken;
  const OnCodeSent({required this.resendToken, required this.verificationId});
}

class OnVerificationFailed extends AuthStateEvent {
  final FirebaseAuthException exception;
  const OnVerificationFailed({required this.exception});
}

class OnCodeAutoRetrievalTimeout extends AuthStateEvent {
  final String verificationId;
  const OnCodeAutoRetrievalTimeout({required this.verificationId});
}

class OnVerifyEvent extends AuthStateEvent {
  final String phoneNumber;
  const OnVerifyEvent({required this.phoneNumber});
}

class OnNotVerifiedEvent extends AuthStateEvent {
  final bool isNewUser;
  const OnNotVerifiedEvent({required this.isNewUser});
}

class OnResendConfirmationCodeEvent extends AuthStateEvent {
  final int? resendToken;
  const OnResendConfirmationCodeEvent({required this.resendToken});
}

class OnConfirmEvent extends AuthStateEvent {
  final String code;
  // late BuildContext context;
  const OnConfirmEvent({required this.code});
}

class OnConfirmedEvent extends AuthStateEvent {
  final User user;
  const OnConfirmedEvent({required this.user});
}
