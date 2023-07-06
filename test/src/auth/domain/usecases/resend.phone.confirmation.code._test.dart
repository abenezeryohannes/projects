import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/auth/domain/respositories/i.auth.repository.dart';
import 'package:rnginfra/src/auth/domain/usecases/resend.phone.confirmation.code.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockFirebaseAuthEntity extends Mock implements IFirebaseAuthEntity {}

void main() {
  late ResendPhoneConfirmationCode usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = ResendPhoneConfirmationCode(signInRepository: mockAuthRepository);
  });

  MockFirebaseAuthEntity mockFirebaseAuthEntity = MockFirebaseAuthEntity();
  ResendPhoneConfirmationCodeParam param =
      ResendPhoneConfirmationCodeParam(firebaseDto: mockFirebaseAuthEntity);

  test(
      'should get IFirebaseAuthEntity when resendPhoneConfirmationCode from the repository',
      () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    // When resendPhoneConfirmationCode is called with any argument, always answer with
    // the Right "side" of Either containing a test irebaseAuthEntity object.
    when(mockAuthRepository.resendPhoneConfirmationCode(mockFirebaseAuthEntity))
        .thenAnswer((_) async => Right(mockFirebaseAuthEntity));
    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.call(param);
    // UseCase should simply return whatever was returned from the Repository
    expect(result, Right(mockFirebaseAuthEntity));
    // Verify that the method has been called on the Repository
    verify(
        mockAuthRepository.resendPhoneConfirmationCode(mockFirebaseAuthEntity));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
