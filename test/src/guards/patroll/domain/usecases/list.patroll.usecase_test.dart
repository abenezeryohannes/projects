import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/list.patroll.usecase.dart';

class MockPatrollRepo extends Mock implements IPatrollRepository {}

main() {
  late MockPatrollRepo mockPatrollRepo;
  late ListPatrollUseCase useCase;
  late PatrollEntity pat;
  late ListPatrollParam params;
  setUp(() {
    mockPatrollRepo = MockPatrollRepo();

    useCase = ListPatrollUseCase(patrollRepository: mockPatrollRepo);

    pat = PatrollEntity(
        qr_code_gps_lat: 2.234,
        qr_code_gps_lng: 2.342,
        qr_code_id: 234,
        body: 'Body',
        created: DateTime.now(),
        scanned_qr_code_id: 123,
        title: 'Title');

    params = const ListPatrollParam(page: 1, limit: 1);
  });

  test('should get Patrolls list from the repository during fetching ',
      () async {
    //stubbing
    when(mockPatrollRepo.listPatroll()).thenAnswer((_) async => Right([pat]));

    //arrange
    final result = await useCase(params);

    //check
    verify(mockPatrollRepo.listPatroll(limit: params.limit, page: params.page));
    expect(result, Right([pat]));
  });
}
