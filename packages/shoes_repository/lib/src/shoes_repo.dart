import 'models/models.dart';

abstract class ShoesRepo {
    Future<List<Shoes>> getShoes();
}
