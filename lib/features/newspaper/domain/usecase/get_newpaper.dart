import 'package:assessment_swavalambanam/core/error/failure.dart';
import 'package:assessment_swavalambanam/core/usecase.dart';
import 'package:assessment_swavalambanam/features/newspaper/domain/repository/newspaper_repository.dart';

import '../entities/newspaper.dart';
import 'package:fpdart/fpdart.dart';

class GetNewspapers implements UseCase<List<Newspaper>,NoParams> {
  final NewspaperRepository repository;

  GetNewspapers(this.repository);

  @override
  Future<Either<Failure, List<Newspaper>>> call(NoParams params) async {
    return await repository.getNewspapers();
  }
}
