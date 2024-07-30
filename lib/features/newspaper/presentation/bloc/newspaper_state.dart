part of 'newspaper_bloc.dart';

@immutable
sealed class NewspaperState {
  const NewspaperState();
}

class NewspaperInitial extends NewspaperState {}

class NewspaperLoading extends NewspaperState {}

class NewspaperLoaded extends NewspaperState {
  final List<Newspaper> newspapers;

  const NewspaperLoaded({required this.newspapers});
}

class NewspaperErrorState extends NewspaperState {
  final String message;

  const NewspaperErrorState({required this.message});
}
