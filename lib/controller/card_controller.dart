// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:fampay_assignment/model/api_response_model.dart';
import 'package:fampay_assignment/static/network_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  //fetch response from api
  Future<void> fetchApiData() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      // api call
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'FamPay-Assignment-App/1.0',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Request timeout after 10 seconds');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = json.decode(response.body);
        // print('API Response successful');

        _apiData.value = apiDataFromJson(response.body);
        _error.value = '';
      } else {
        throw HttpException(
            'HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      _error.value = 'Network Error: Please check your internet connection';
      print('SocketException: $e');
      await _loadFallbackData();
    } on TimeoutException catch (e) {
      _error.value =
          'Request Timeout: The server is taking too long to respond';
      print('TimeoutException: $e');
      await _loadFallbackData();
    } on FormatException catch (e) {
      _error.value = 'Data Format Error: Invalid response from server';
      print('FormatException: $e');
    } on HttpException catch (e) {
      _error.value = 'Server Error: ${e.message}';
      print('HttpException: $e');
    } catch (e) {
      _error.value = 'Unexpected Error: $e';
      print('General Exception: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  //demo if api not accessible
  Future<void> _loadFallbackData() async {
    try {
      print('Loading fallback mock data...');

      //mock data
      final mockApiResponse = [
        {
          "id": 1,
          "slug": "famx-paypage-fallback",
          "title": "Offline Mode",
          "formatted_title": null,
          "description": "Demo data - API not accessible",
          "formatted_description": null,
          "assets": null,
          "hc_groups": [
            {
              "id": 1,
              "name": "fallback_hc3",
              "design_type": "HC3",
              "card_type": 1,
              "cards": [
                {
                  "id": 1,
                  "name": "Fallback Card",
                  "slug": "fallback-card",
                  "title": "Welcome to FamPay Assignment",
                  "formatted_title": {
                    "text": "Welcome to {} Assignment\n{}",
                    "align": "left",
                    "entities": [
                      {
                        "text": "FamPay",
                        "type": "generic_text",
                        "color": "#FB6441",
                        "font_size": 30,
                        "font_style": "underline",
                        "font_family": "met_semi_bold"
                      },
                      {
                        "text":
                            "This is demo data shown when API is not accessible",
                        "type": "generic_text",
                        "color": "#FFFFFF",
                        "font_size": 16,
                        "font_style": "normal",
                        "font_family": "met_regular"
                      }
                    ]
                  },
                  "positional_images": [],
                  "components": [],
                  "url": "https://fampay.in",
                  "bg_color": "#FB6441",
                  "bg_gradient": {
                    "angle": 45,
                    "colors": ["#FB6441", "#FFBB33"]
                  },
                  "cta": [
                    {
                      "text": "Visit FamPay",
                      "type": "normal",
                      "bg_color": "#FFFFFF",
                      "text_color": "#FB6441",
                      "url": "https://fampay.in",
                      "is_circular": false,
                      "is_secondary": false,
                      "stroke_width": 0
                    }
                  ],
                  "is_disabled": false,
                  "is_shareable": true,
                  "is_internal": false
                }
              ],
              "is_scrollable": false,
              "height": 350,
              "is_full_width": false,
              "level": 0
            },
            {
              "id": 2,
              "name": "fallback_hc1",
              "design_type": "HC1",
              "card_type": 1,
              "cards": [
                {
                  "id": 2,
                  "name": "Demo Small Card 1",
                  "slug": "demo-card-1",
                  "title": "Demo Card",
                  "formatted_title": {
                    "text": "{}",
                    "align": "left",
                    "entities": [
                      {
                        "text": "Small Display Card",
                        "type": "generic_text",
                        "color": "#000000",
                        "font_size": 14,
                        "font_style": "normal",
                        "font_family": "met_semi_bold"
                      }
                    ]
                  },
                  "formatted_description": {
                    "text": "{}",
                    "align": "left",
                    "entities": [
                      {
                        "text": "Demo Description",
                        "type": "generic_text",
                        "color": "#666666",
                        "font_size": 12,
                        "font_style": "normal",
                        "font_family": "met_regular"
                      }
                    ]
                  },
                  "positional_images": [],
                  "components": [],
                  "bg_color": "#E8F4FD",
                  "url": "https://fampay.in",
                  "is_disabled": false,
                  "is_shareable": false,
                  "is_internal": false
                },
                {
                  "id": 3,
                  "name": "Demo Small Card 2",
                  "slug": "demo-card-2",
                  "title": "Demo Card 2",
                  "formatted_title": {
                    "text": "{}",
                    "align": "left",
                    "entities": [
                      {
                        "text": "Another Demo Card",
                        "type": "generic_text",
                        "color": "#000000",
                        "font_size": 14,
                        "font_style": "normal",
                        "font_family": "met_semi_bold"
                      }
                    ]
                  },
                  "formatted_description": {
                    "text": "{}",
                    "align": "left",
                    "entities": [
                      {
                        "text": "Offline mode active",
                        "type": "generic_text",
                        "color": "#666666",
                        "font_size": 12,
                        "font_style": "normal",
                        "font_family": "met_regular"
                      }
                    ]
                  },
                  "positional_images": [],
                  "components": [],
                  "bg_color": "#FFF2E8",
                  "url": "https://fampay.in",
                  "is_disabled": false,
                  "is_shareable": false,
                  "is_internal": false
                }
              ],
              "is_scrollable": true,
              "height": 64,
              "is_full_width": false,
              "level": 1
            }
          ]
        }
      ];

      final jsonString = json.encode(mockApiResponse);
      _apiData.value = apiDataFromJson(jsonString);
      _error.value = 'Using offline demo data - API not accessible';
    } catch (e) {
      print('Failed to load fallback data: $e');
      _error.value = 'No data available';
    }
  }

  Future<void> refreshData() async {
    await fetchApiData();
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() => message;
}
