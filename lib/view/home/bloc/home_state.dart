part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<AnimalModel> animals;
  final List<AnimalModel> animalsCompleteList;
  HomeLoaded({required this.animals,required this.animalsCompleteList});
}
