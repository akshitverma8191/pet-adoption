part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {
  final List<AnimalModel> animals;
  HistoryInitial({required this.animals});
}
