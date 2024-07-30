import 'package:assessment_swavalambanam/core/error/exception.dart';
import 'package:assessment_swavalambanam/core/error/failure.dart';
import 'package:assessment_swavalambanam/features/newspaper/data/datasource/newspaper_remote_source.dart';
import 'package:assessment_swavalambanam/features/newspaper/domain/repository/newspaper_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../models/newspaper_model.dart';

class NewsRepositoryImpl implements NewspaperRepository {
  final NewspaperRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewspaperModel>>> getNewspapers() async {
    try {
      final newspapers = await remoteDataSource.fetchNewspapers();
      return right(newspapers);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      // Log the error if needed
      return left(Failure(
          message:
              "Error Ocurred")); // Return a failure for any other exception
    }
  }
}
