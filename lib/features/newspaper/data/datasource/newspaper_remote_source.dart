import 'dart:convert';
import 'package:assessment_swavalambanam/core/error/exception.dart';
import 'package:http/http.dart' as http;
import '../models/newspaper_model.dart';

abstract class NewspaperRemoteDataSource {
  Future<List<NewspaperModel>> fetchNewspapers();
}

class NewspaperRemoteDataSourceImpl implements NewspaperRemoteDataSource {
  final http.Client client;

  NewspaperRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewspaperModel>> fetchNewspapers() async {
    try {
      final response = await client.get(
        Uri.parse(
            'https://chroniclingamerica.loc.gov/search/titles/results/?terms=oakland&format=json&page=1'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['items'];
        return jsonData.map((item) => NewspaperModel.fromJson(item)).toList();
      } else {
        throw const ServerException(
          "An Unexpected error ocurred",
        ); // Throw exception for non-200 responses
      }
    } catch (e) {
      // Log the error if needed
      throw ServerException(
        e.toString(),
      ); // Throw a specific exception for error handling
    }
  }
}
