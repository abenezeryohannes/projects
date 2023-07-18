import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rnginfra/src/guards/core/data/pager.dto.dart';
import 'package:rnginfra/src/guards/core/data/pagination.dto.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/list.patroll.usecase.dart';

class MockPatrollRepo extends Mock implements IPatrollRepository {}

main() {
  late MockPatrollRepo mockPatrollRepo;
  late ListPatrollUseCase useCase;
  late PatrollEntity pat;
  late AddPatrollDto req;
  late ListPatrollParam params;
  setUp(() {
    mockPatrollRepo = MockPatrollRepo();

    useCase = ListPatrollUseCase(patrollRepository: mockPatrollRepo);

    req = const AddPatrollDto(
      latitude: 2.234,
      longitude: 2.342,
      qr_code_id: 234,
    );

    pat = PatrollEntity(
        scanned_qr_code_gps_lat: '2.234',
        scanned_qr_code_gps_lng: '2.342',
        scanned_qr_code_id: '234',
        body: 'Body',
        created: DateTime.now(),
        title: 'Title');

    params = const ListPatrollParam(page: 1, limit: 1);
  });

  test('should get Patrolls list from the repository during fetching ',
      () async {
    //stubbing
    when(mockPatrollRepo.listPatroll()).thenAnswer((_) async => Right(
        Pagination(
            results: [pat],
            pager: Pager(
                count: '0', pages: 1, items_per_page: 1, current_page: 0))));

    //arrange
    final result = await useCase(params);

    //check
    verify(mockPatrollRepo.listPatroll(limit: params.limit, page: params.page));
    expect(result, Right([pat]));
  });
}
