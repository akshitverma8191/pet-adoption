import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petadoption/data/asset_data_source.dart';
import 'package:petadoption/data/data_manager.dart';
import 'package:petadoption/model/animal_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit){
    });
    on<HomeEventLoadInitialData>((event,emit) async {
      final assetDataSource = AssetDataSource('assets/data/animal_list.json');

      final dataManager =  DataManager(dataSource: assetDataSource);

      final data = await dataManager.getData();

      List<AnimalModel> animals = [];
      for(final obj in data){
        animals.add(AnimalModel(obj));
      }

      emit(HomeLoaded(animals: animals, animalsCompleteList: animals));
    } );
  on<HomeEventSearch>((event, emit) {

    if(state is HomeLoaded){
      final HomeLoaded currentState = state as HomeLoaded;
      final List<AnimalModel> animals = currentState.animals;
      final List<AnimalModel> filteredAnimals = currentState.animalsCompleteList.where((element) => element.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(HomeLoaded(animals: event.query.isEmpty? currentState.animalsCompleteList :filteredAnimals, animalsCompleteList: currentState.animalsCompleteList));
    }
  });
  on<HomeEventAdoptAnimal>((event,emit){
    if(state is HomeLoaded){
      final HomeLoaded currentState = state as HomeLoaded;
      final List<AnimalModel> animals = currentState.animals;
      final List<AnimalModel> updatedAnimals = animals.map((e) => e.id == event.id? e.updateSoldStatus(event.status): e).toList();
      emit(HomeLoaded(animals: updatedAnimals, animalsCompleteList: currentState.animalsCompleteList));
    }
  });

  }
}
