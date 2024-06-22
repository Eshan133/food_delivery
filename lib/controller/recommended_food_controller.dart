import 'package:food_delivery_latest/api/repo/repository/recommended_food_repo.dart';
import 'package:food_delivery_latest/model/product_model.dart';
import 'package:get/get.dart';

class RecommendedFoodController extends GetxController {
  late RecommendedFoodRepo recommendedFoodRepo;

  RecommendedFoodController({required this.recommendedFoodRepo});

  List<dynamic> _recommendedFoodList = [];
  List<dynamic> get recommendedFoodList => _recommendedFoodList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedFoodList() async {
    Response response = await recommendedFoodRepo.getRecommendedFoodList();

    if (response.statusCode == 200) {
      _recommendedFoodList = [];
      _recommendedFoodList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("no response");
    }
  }
}
