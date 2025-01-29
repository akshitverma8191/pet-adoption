import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/model/animal_model.dart';
import 'package:petadoption/utils/text_style_helper.dart';

import '../home/bloc/home_bloc.dart';

class DetailPage extends StatefulWidget {
  final AnimalModel animalModel;

  const DetailPage({super.key, required this.animalModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late AnimalModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.animalModel;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            model.name,
            style: appTextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(children: [
          Hero(
              tag: model.id,
              child: Container(
                height: size.height * 0.45,
                width: size.width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(model.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(size.width * 0.9),
                      bottomLeft: Radius.circular(size.width * 0.9)),
                  color: () {
                    switch (model.category) {
                      case "dog":
                        return Colors.pink.shade50;
                      case "cat":
                        return Colors.teal.shade100;
                      case "bird":
                        return Colors.orangeAccent.shade100;
                    }
                    return Colors.teal.shade50;
                  }(),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
            child: InkWell(
              onTap: (){
                setState(() {
                  model = model.updateSoldStatus(!model.isSold);
                });
                BlocProvider.of<HomeBloc>(context).add(HomeEventAdoptAnimal(id: model.id, status: model.isSold));
              },
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: model.isSold? Colors.grey :Colors.black,
                ),
                alignment: Alignment.center,
                child: Text(
                  model.isSold ? 'Release me' : 'Adopt me',
                  style: appTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Text('Price: \$${model.price}',
            style: appTextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
          const SizedBox(height: 8,),
          Text('Distance: ${model.distance} km',
            style: appTextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
        ]));
  }
}
