import 'package:food_delivery_latest/api/repo/api_client.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo extends GetxService {
  late ApiClient apiClient;

  RecommendedFoodRepo({required this.apiClient});

  Future<Response> getRecommendedFoodList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_URL);
  }
}
