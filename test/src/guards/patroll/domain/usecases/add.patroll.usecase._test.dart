import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/add.patroll.usecase.dart';

class MockPatrollRepo extends Mock implements IPatrollRepository {}

main() {
  late MockPatrollRepo mockPatrollRepo;
  late AddPatrollUseCase useCase;
  late AddPatrollDto pat;
  late PatrollEntity res;
  late AddPatrollParam params;
  setUp(() {
    mockPatrollRepo = MockPatrollRepo();

    useCase = AddPatrollUseCase(patrollRepository: mockPatrollRepo);

    pat = const AddPatrollDto(
      latitude: 2.234,
      longitude: 2.342,
      qr_code_id: 234,
    );

    res = PatrollEntity(
        scanned_qr_code_gps_lat: '2.234',
        scanned_qr_code_gps_lng: '2.342',
        scanned_qr_code_id: '234',
        body: 'Body',
        created: DateTime.now(),
        title: 'Title');

    params = AddPatrollParam(patroll: pat);
  });

  test('should get Patroll entity from the repository when patroll is added ',
      () async {
    //stubbing
    when(mockPatrollRepo.addPatroll(patroll: params.patroll))
        .thenAnswer((_) async => const Right(true));

    //arrange
    final result = await useCase(params);

    //check
    verify(mockPatrollRepo.addPatroll(patroll: params.patroll));
    expect(result, Right(pat));
  });
}
