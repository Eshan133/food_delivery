import 'package:food_delivery_latest/api/repo/api_client.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends GetxService {
  late ApiClient apiClient;

  PopularFoodRepo({required this.apiClient});

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_FOOD_URL);
  }
}
