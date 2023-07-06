import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/auth/domain/respositories/i.auth.repository.dart';
import 'package:rnginfra/src/auth/domain/usecases/sign.out.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockFirebaseAuthEntity extends Mock implements IFirebaseAuthEntity {}

void main() {
  late SignOut usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignOut(signInRepository: mockAuthRepository);
  });

  MockFirebaseAuthEntity mockFirebaseAuthEntity = MockFirebaseAuthEntity();
  SignOutParam param = SignOutParam(firebaseDto: mockFirebaseAuthEntity);

  test('should get IFirebaseAuthEntity when SignOut from the repository',
      () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    // When SignOut is called with any argument, always answer with
    // the Right "side" of Either containing a test irebaseAuthEntity object.
    when(mockAuthRepository.signOut(mockFirebaseAuthEntity))
        .thenAnswer((_) async => Right(mockFirebaseAuthEntity));
    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.call(param);
    // UseCase should simply return whatever was returned from the Repository
    expect(result, Right(mockFirebaseAuthEntity));
    // Verify that the method has been called on the Repository
    verify(mockAuthRepository.signOut(mockFirebaseAuthEntity));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
