import 'package:assessment_swavalambanam/core/usecase.dart';
import 'package:assessment_swavalambanam/features/newspaper/domain/usecase/get_newpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/newspaper.dart';

part 'newspaper_event.dart';
part 'newspaper_state.dart';

class NewspaperBloc extends Bloc<NewspaperEvent, NewspaperState> {
  final GetNewspapers getNewspapers;

  NewspaperBloc({required this.getNewspapers}) : super(NewspaperInitial()) {
    on<GetNewspaperList>((event, emit) async {
      emit(NewspaperLoading());
      final failureOrNewspapers = await getNewspapers(NoParams());
      failureOrNewspapers.fold(
        (failure) {
          emit(NewspaperErrorState(message: failure.message));
        },
        (newspapers) {
          emit(NewspaperLoaded(newspapers: newspapers));
        },
      );
    });
  }
}
