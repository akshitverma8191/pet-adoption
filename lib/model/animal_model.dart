

class AnimalModel {

  late final int id;
  late final String name;
  late final int price;
  late final String category;
  late bool isSold;
  late final double distance;
  late final String imageUrl;

  AnimalModel(Map data){
    id = data['id'];
    name = data['name'];
    price = data['price'];
    category = data['category'];
    isSold = data['isSold'];
    distance = data['distance'];
    imageUrl  = data['image'];
  }

  AnimalModel updateSoldStatus(bool isSold){
    this.isSold = isSold;
    return this;
  }
}