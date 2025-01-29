part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class HistoryEventAddAnimal extends HistoryEvent {
  final AnimalModel animalModel;
  HistoryEventAddAnimal({required this.animalModel});
}


class HistoryEventRemoveAnimal extends HistoryEvent {
  final AnimalModel animalModel;
  HistoryEventRemoveAnimal({required this.animalModel});
}