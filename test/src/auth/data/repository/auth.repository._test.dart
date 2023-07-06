import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/auth/data/datasources/auth.local.datasource.dart';
import 'package:rnginfra/src/auth/data/datasources/auth.remote.datasource.dart';
import 'package:rnginfra/src/auth/data/respositories/auth.repository.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/network/network.info.dart';

import '../../domain/entities/firebase.mock.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockFirebaseAuthEntity extends Mock implements IFirebaseAuthEntity {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AuthRepository authRepository;
  late MockUser mockUser;

  MockFirebaseAuthEntity mockFirebaseAuthEntity = MockFirebaseAuthEntity();
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    mockNetworkInfo = MockNetworkInfo();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockUser = MockUser();
    authRepository = AuthRepository(
        networkInfo: mockNetworkInfo,
        authRemoteDataSource: mockAuthRemoteDataSource,
        authLocalDataSource: mockAuthLocalDataSource);
  });

  test(
      'should check if the device is online when calling any authentication calls',
      () async {
    //stab
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => (true));
    //act
    await authRepository.verifyPhoneNumber(mockFirebaseAuthEntity);
    await authRepository.confirmPhoneConfirmationCode(mockFirebaseAuthEntity);
    await authRepository.resendPhoneConfirmationCode(mockFirebaseAuthEntity);
    await authRepository.signOut(mockFirebaseAuthEntity);

    //assert
    verify(mockNetworkInfo.isConnected).called(4);
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    //
    // verify phone
    //
    test('should ask for phone verification online when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.verifyPhoneNumber(
              mockFirebaseAuthEntity, false))
          .thenAnswer((_) async => mockFirebaseAuthEntity);
      //act
      final result =
          await authRepository.verifyPhoneNumber(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(
          mockFirebaseAuthEntity, false));
      expect(result, equals(Right(mockFirebaseAuthEntity)));
    });

    test(
        'should return failure on phone verification if something went wrong when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.verifyPhoneNumber(
              mockFirebaseAuthEntity, false))
          .thenAnswer((_) async => null);
      //act
      final result =
          await authRepository.verifyPhoneNumber(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(
          mockFirebaseAuthEntity, false));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });

    ////
    /// for confirm phone confirmation code
    ///
    test('should ask for confirming code online when the device is online',
        () async {
      //stub
      when(mockFirebaseAuthEntity.user).thenReturn(mockUser);
      when(mockAuthRemoteDataSource
              .confirmPhoneConfirmationCode(mockFirebaseAuthEntity))
          .thenAnswer((_) async => mockFirebaseAuthEntity);
      //act
      final result = await authRepository
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity));
      expect(result, equals(Right(mockFirebaseAuthEntity)));
    });

    test(
        'should return failure on confirming code if the user is not optained form firebase when the device is online',
        () async {
      //stub
      when(mockFirebaseAuthEntity.user).thenReturn(null);
      when(mockAuthRemoteDataSource
              .confirmPhoneConfirmationCode(mockFirebaseAuthEntity))
          .thenAnswer((_) async => mockFirebaseAuthEntity);
      //act
      final result = await authRepository
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });

    test(
        'should return failure on confirming code if something unexpected happen when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource
              .confirmPhoneConfirmationCode(mockFirebaseAuthEntity))
          .thenAnswer((_) async => null);
      //act
      final result = await authRepository
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });

    ///
    ///for resend phone confirmation code
    ///
    test(
        'should ask for resend phone verification online when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.verifyPhoneNumber(
              mockFirebaseAuthEntity, true))
          .thenAnswer((_) async => mockFirebaseAuthEntity);
      //act
      final result = await authRepository
          .resendPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(
          mockFirebaseAuthEntity, true));
      expect(result, equals(Right(mockFirebaseAuthEntity)));
    });

    test(
        'should return failure on resend phone verification if something unexpected happen when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.verifyPhoneNumber(
              mockFirebaseAuthEntity, true))
          .thenAnswer((_) async => null);
      //act
      final result = await authRepository
          .resendPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(
          mockFirebaseAuthEntity, true));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });

    ///
    ///for sign out
    ///
    test('should ask for signing out online when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity))
          .thenAnswer((_) async => true);
      //act
      final result = await authRepository.signOut(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity));
      expect(result, equals(Right(mockFirebaseAuthEntity)));
    });

    test(
        'should return failure on sign out if something unexpected happen when the device is online',
        () async {
      //stub
      when(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity))
          .thenAnswer((_) async => null);
      //act
      final result = await authRepository.signOut(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });

    test(
        'should call firebaseAuthEntity signOut method when signing out is successful',
        () async {
      //stub
      when(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity))
          .thenAnswer((_) async => true);
      //act
      final result = await authRepository.signOut(mockFirebaseAuthEntity);
      //assert
      verify(mockFirebaseAuthEntity.signOut());
      expect(result, equals(Right(mockFirebaseAuthEntity)));
    });

    test(
        'should return failure when signing out failed in firebase call side unexpectedly',
        () async {
      //stub
      when(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity))
          .thenAnswer((_) async => false);
      //act
      final result = await authRepository.signOut(mockFirebaseAuthEntity);
      //assert
      verify(mockAuthRemoteDataSource.signOut(mockFirebaseAuthEntity));
      expect(
          result,
          equals(
              Left(UnExpectedFailure(message: UnExpectedException().message))));
    });
  });
  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
        'should return network failure when verifing phone number if the device is offline',
        () async {
      //act
      final result =
          await authRepository.verifyPhoneNumber(mockFirebaseAuthEntity);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result,
          equals(Left(NetworkFailure(message: NetworkException().message))));
    });
    test(
        'should return network failure when signing out if the device is offline',
        () async {
      //act
      final result = await authRepository.signOut(mockFirebaseAuthEntity);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result,
          equals(Left(NetworkFailure(message: NetworkException().message))));
    });
    test(
        'should return network failure when confirming confirmation code if the device is offline',
        () async {
      //act
      final result = await authRepository
          .confirmPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result,
          equals(Left(NetworkFailure(message: NetworkException().message))));
    });
    test(
        'should return network failure when resend verification code if the device is offline',
        () async {
      //act
      final result = await authRepository
          .resendPhoneConfirmationCode(mockFirebaseAuthEntity);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result,
          equals(Left(NetworkFailure(message: NetworkException().message))));
    });
  });
}
