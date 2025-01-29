import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/route/routes.dart';
import 'package:petadoption/view/history/bloc/history_bloc.dart';
import 'package:petadoption/view/home/bloc/home_bloc.dart';

import '../../model/animal_model.dart';
import '../../utils/text_style_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((time) {
      BlocProvider.of<HomeBloc>(context).add(HomeEventLoadInitialData());
    });
  }


  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('did update on widget');
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('did change dependencies');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  appBar(),
                  const SizedBox(height: 8,),
                  searchField(),
                  const SizedBox(height: 8,),
                  if(state is HomeLoaded)Expanded(
                    child: SizedBox(
                      child: ListView.builder(itemCount: state.animals.length,
                          itemBuilder: (_, ind) {
                            return animalCard(state.animals[ind]);
                          }),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }


  // UI widgets

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's find",
              style: appTextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
            const SizedBox(height: 8,),
            Text("Little Friends",
              style: appTextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
          ],
        ),
        IconButton(onPressed: () {
          Navigator.pushNamed(context, Routes.historyPage);
        }, icon: const  Icon(Icons.history))
      ],
    );
  }

  Widget searchField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(50)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8,),
          Expanded(child: TextField(
            onChanged: (val) {
                BlocProvider.of<HomeBloc>(context).add(HomeEventSearch(query: val));
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for pets'
            ),
          )),
        ],
      ),
    );
  }

  Widget animalCard(AnimalModel animalmodel) {
    {
      return InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.detailPage, arguments: animalmodel);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
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
              borderRadius: BorderRadius.circular(24)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(animalmodel.name,
                      style: appTextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    const SizedBox(height: 8,),
                    Text('Price: INR ${animalmodel.price}',
                      style: appTextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                    const SizedBox(height: 8,),
                    Text('Distance: ${animalmodel.distance} km',
                      style: appTextStyle(fontWeight: FontWeight.w500, fontSize: 12),),

                    InkWell(onTap: (){
                      if(!animalmodel.isSold){
                        BlocProvider.of<HomeBloc>(context).add(HomeEventAdoptAnimal(id: animalmodel.id, status: !animalmodel.isSold));
                        BlocProvider.of<HistoryBloc>(context).add(HistoryEventAddAnimal(animalModel: animalmodel));
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('Congratulations! You have adopted ${animalmodel.name}. Please check history section for adopted list.'),
                            titleTextStyle: appTextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Ok',style: appTextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.teal),))
                            ],
                          );
                        });
                      }

                    },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: animalmodel.isSold? Colors.grey : Colors.black
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                        child: Text( animalmodel.isSold? 'Already adopted' :'Adopt me',style: appTextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white),),
                      ),
                    ),

                  ],
                ),
              ),
              Hero(
                tag: animalmodel.id,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: CachedNetworkImageProvider(animalmodel.imageUrl),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

}
