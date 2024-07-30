import 'package:assessment_swavalambanam/features/newspaper/domain/entities/newspaper.dart';

class NewspaperModel extends Newspaper {
  NewspaperModel(
      {required super.title,
      required super.placeOfPublication,
      required super.startYear,
      required super.endYear,
      required super.publisher,
      required super.url,
      required super.subjects,
      required super.lccn,
      required super.language});

  factory NewspaperModel.fromJson(Map<String, dynamic> json) {
    return NewspaperModel(
      title: json['title'] ?? "",
      placeOfPublication: json['place_of_publication'] ?? "",
      startYear: json['start_year'] ?? "",
      endYear: json['end_year'] ?? "",
      publisher: _parsePublisher(json['publisher']),
      url: json['url'] ?? "",
      subjects: List<String>.from(json['subject']),
      lccn: json['lccn'] ?? "",
      language: List<String>.from(
        json["language"],
      ),
    );
  }
  @override
  String toString() {
    return "tilte : $title, pop:$placeOfPublication, start:$startYear, end:$endYear, pub:$publisher, url:$url, subject:$subjects, lccn:$lccn";
  }

  static String _parsePublisher(dynamic publisherData) {
    if (publisherData is String) {
      // Remove brackets and extra spaces
      final cleanedString =
          publisherData.replaceAll(RegExp(r'[\[\]"]'), '').trim();
      return cleanedString;
    }
    return ''; // Return an empty string if not handled
  }
}
