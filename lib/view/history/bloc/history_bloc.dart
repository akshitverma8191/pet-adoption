import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/animal_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial(animals: const [])) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<HistoryEventAddAnimal>((event,emit){
      if(state is HistoryInitial){
        final HistoryInitial currentState = state as HistoryInitial;
        final List<AnimalModel> animals = currentState.animals;
        event.animalModel.epoch = DateTime.now().millisecondsSinceEpoch;
        final List<AnimalModel> updatedAnimals = List.from(animals)..add(event.animalModel);
        updatedAnimals.sort((a,b) => (a.epoch?? 0).compareTo(b.epoch ?? 0));
        emit(HistoryInitial(animals: updatedAnimals));
      }
    });

    on<HistoryEventRemoveAnimal>((event,emit){
      if(state is HistoryInitial){
        final HistoryInitial currentState = state as HistoryInitial;
        final List<AnimalModel> animals = currentState.animals;
        final List<AnimalModel> updatedAnimals = animals.where((element) => element.id != event.animalModel.id).toList();
        emit(HistoryInitial(animals: updatedAnimals));
      }
    });
  }
}
