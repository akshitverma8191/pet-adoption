
abstract class DataSource{
  Future<dynamic> getData();
}

class DataManager{
  final DataSource dataSource;

  DataManager({required this.dataSource});

  Future<dynamic> getData() async{
    return await dataSource.getData();
  }
}