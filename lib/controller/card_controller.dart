import 'package:fampay_assignment/model/api_response_model.dart';
import 'package:fampay_assignment/static/network_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController extends GetxController {
  final _isLoading = false.obs;
  final _apiData = <ApiData>[].obs;
  final _error = ''.obs;

  bool get isLoading => _isLoading.value;
  List<ApiData> get apiData => _apiData;
  String get error => _error.value;

  final String baseUrl = NetworkUrl.url;

  @override
  void onInit() {
    super.onInit();
    fetchApiData();
  }

  Future<void> fetchApiData() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await http.get(
        Uri.parse(baseUrl),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = json.decode(response.body);

        _apiData.value = apiDataFromJson(response.body);

        _error.value = '';
      } else {
        _error.value =
            'Failed to load data. Status code: ${response.statusCode}';
        _apiData.clear();
      }
    } catch (e) {
      _error.value = 'Error fetching data: $e';
      _apiData.clear();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchApiData();
  }
}
