import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/add.patroll.usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/edit.patroll.usecase.dart';

class MockPatrollRepo extends Mock implements IPatrollRepository {}

main() {
  late MockPatrollRepo mockPatrollRepo;
  late EditPatrollUseCase useCase;
  late PatrollEntity pat;
  late EditPatrollParam params;
  setUp(() {
    mockPatrollRepo = MockPatrollRepo();

    useCase = EditPatrollUseCase(patrollRepository: mockPatrollRepo);

    pat = PatrollEntity(
        qr_code_gps_lat: 2.234,
        qr_code_gps_lng: 2.342,
        qr_code_id: 234,
        body: 'Body',
        created: DateTime.now(),
        scanned_qr_code_id: 123,
        title: 'Title');

    params = EditPatrollParam(1, patroll: pat);
  });

  test('should get Patroll entity from the repository when patroll is added ',
      () async {
    //stubbing
    when(mockPatrollRepo.editPatroll(patroll: params.patroll, id: 1))
        .thenAnswer((_) async => Right(pat));

    //arrange
    final result = await useCase(params);

    //check
    verify(mockPatrollRepo.editPatroll(patroll: params.patroll, id: 1));
    expect(result, Right(pat));
  });
}
