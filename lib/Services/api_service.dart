import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'api_config.dart';
import '../Model/recommendation.dart';
import '../Model/demand_prediction.dart';

class ApiService {
  final String baseUrl;
  ApiService({this.baseUrl = ApiConfig.baseUrl});

  /// Fetch recommendations. Default: POST { "user_id": <id> } returns a list
  Future<List<Recommendation>> getRecommendations({String userId}) async {
    final uri = Uri.parse('$baseUrl/recommend');
    final body = userId != null ? jsonEncode({'user_id': userId}) : null;
    final response = await http
        .post(uri, headers: {'Content-Type': 'application/json'}, body: body)
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data.map((e) => Recommendation.fromJson(e)).toList();
      } else if (data is Map) {
        if (data['recommendations'] is List) {
          return (data['recommendations'] as List)
              .map((e) => Recommendation.fromJson(e))
              .toList();
        }
      }
      throw Exception('Unexpected response format');
    } else {
      throw Exception('Failed to fetch recommendations (${response.statusCode})');
    }
  }

  /// Predict demand for an item. POST { "item_id": <id> } returns { prediction: [...] }
  Future<DemandPrediction> predictDemand({String itemId}) async {
    final uri = Uri.parse('$baseUrl/predict-demand');
    final body = jsonEncode({'item_id': itemId});
    final response = await http
        .post(uri, headers: {'Content-Type': 'application/json'}, body: body)
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map) {
        return DemandPrediction.fromJson(data);
      }
      throw Exception('Unexpected response format');
    } else {
      throw Exception('Failed to fetch prediction (${response.statusCode})');
    }
  }
}
