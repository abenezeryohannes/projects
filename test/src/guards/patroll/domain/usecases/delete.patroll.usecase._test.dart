import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/add.patroll.usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/delete.patroll.usecase.dart';

class MockPatrollRepo extends Mock implements IPatrollRepository {}

main() {
  late MockPatrollRepo mockPatrollRepo;
  late DeletePatrollUseCase useCase;
  late PatrollEntity pat;
  late DeletePatrollParam params;
  setUp(() {
    mockPatrollRepo = MockPatrollRepo();

    useCase = DeletePatrollUseCase(patrollRepository: mockPatrollRepo);

    pat = PatrollEntity(
        scanned_qr_code_gps_lat: '2.234',
        scanned_qr_code_gps_lng: '2.342',
        scanned_qr_code_id: '234',
        body: 'Body',
        created: DateTime.now(),
        title: 'Title');

    params = DeletePatrollParam(patroll: pat);
  });

  test('should delete Patroll entity when patroll is deactivated ', () async {
    //stubbing
    when(mockPatrollRepo.deletePatroll(patroll: params.patroll))
        .thenAnswer((_) async => const Right(true));

    //arrange
    final result = await useCase(params);

    //checks
    verify(mockPatrollRepo.deletePatroll(patroll: params.patroll));
    expect(result, Right(pat));
  });
}
