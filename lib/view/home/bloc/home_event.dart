part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}


class HomeEventLoadInitialData extends HomeEvent{
}

class HomeEventSearch extends HomeEvent{
  final String query;
  HomeEventSearch({required this.query});
}

class HomeEventAdoptAnimal extends HomeEvent{
  final int id;
  final bool status;
  HomeEventAdoptAnimal({required this.id,required this.status});
}