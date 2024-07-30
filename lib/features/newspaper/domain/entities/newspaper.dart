class Newspaper {
  final String title;
  final String placeOfPublication;
  final int startYear;
  final int endYear;
  final String publisher;
  final String lccn;
  final String url;
  final List<String> subjects;
  final List<String> language;

  Newspaper(
      {required this.title,
      required this.placeOfPublication,
      required this.startYear,
      required this.endYear,
      required this.publisher,
      required this.lccn,
      required this.subjects,
      required this.url,
      required this.language});
}
