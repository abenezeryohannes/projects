import 'package:firebase_auth/firebase_auth.dart';

import 'country.entity.dart';

//
// This interface will hold all valuable information we can pass to the presentation and data layer freely
// we only invoke the methods in the data layer so that the change will be rendered to the presntation layer
//
abstract class IFirebaseAuthEntity {
  bool isNewUser = true;

  late List<MyCountry> countries;

  MyCountry? country;

  late String phoneNumber;

  late String confirmationCode;

  int? resendToken;

  late String verificationId;

  User? user;

  AuthCredential? credential;

  PhoneAuthCredential? phoneAuthCredential;

  void onVerificationComplete(PhoneAuthCredential credential);

  void onVerificationFailed(FirebaseAuthException e);

  Future<void> onCodeSent(String verificationId, int? resendToken);

  void onCodeAutoRetrievalTimeout(String verificationId);

  void signOut() {}

  void clone(IFirebaseAuthEntity f) {}

  //List of countries to select
  Future<List<MyCountry>> getCountries();
}
