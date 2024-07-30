import 'package:assessment_swavalambanam/core/error/failure.dart';
import '../entities/newspaper.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NewspaperRepository {
  Future<Either<Failure, List<Newspaper>>> getNewspapers();
}
