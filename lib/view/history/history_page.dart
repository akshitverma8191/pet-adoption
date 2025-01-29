import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/route/routes.dart';
import 'package:petadoption/utils/text_style_helper.dart';
import 'package:petadoption/view/history/bloc/history_bloc.dart';

import '../../model/animal_model.dart';
import '../home/bloc/home_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 32,
            leading: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'History',
              style: appTextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: state is HistoryInitial
                  ? state.animals.isEmpty
                      ? emptyStateWidget()
                      : ListView.builder(
                          itemCount: state.animals.length,
                          itemBuilder: (_, index) {
                            return animalCard(state.animals[index]);
                          })
                  : emptyStateWidget(), // This empty widget can be replaced with error states and other ui states
            ),
          ),
        );
      },
    );
  }

  Widget emptyStateWidget() {
    return Center(
      child: Text(
        'No animals adopted :(',
        style: appTextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  Widget animalCard(AnimalModel animalmodel) {
    {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.detailPage,
              arguments: animalmodel);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: () {
                switch (animalmodel.category) {
                  case "dog":
                    return Colors.pink.shade50;
                  case "cat":
                    return Colors.teal.shade100;
                  case "bird":
                    return Colors.orangeAccent.shade100;
                }
                return Colors.teal.shade50;
              }(),
              borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animalmodel.name,
                      style: appTextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Price: INR ${animalmodel.price}',
                      style: appTextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Distance: ${animalmodel.distance} km',
                      style: appTextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {

                          BlocProvider.of<HomeBloc>(context).add(
                              HomeEventAdoptAnimal(
                                  id: animalmodel.id,
                                  status: false));
                          BlocProvider.of<HistoryBloc>(context).add(
                              HistoryEventRemoveAnimal(animalModel: animalmodel));
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text('You have released ${animalmodel.name}. Please visit home page to adopt again :).'),
                              titleTextStyle: appTextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('Ok',style: appTextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.teal),))
                              ],
                            );
                          });

                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: animalmodel.isSold
                                ? Colors.grey
                                : Colors.black),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Text(
                          animalmodel.isSold ? 'Release me' : 'Adopt me',
                          style: appTextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Hero(
                tag: animalmodel.id,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage:
                      CachedNetworkImageProvider(animalmodel.imageUrl),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
