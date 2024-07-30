part of 'newspaper_bloc.dart';

@immutable
sealed class NewspaperEvent {
  const NewspaperEvent();
}

class GetNewspaperList extends NewspaperEvent {

  const GetNewspaperList();
}
