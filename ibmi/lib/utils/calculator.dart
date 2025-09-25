import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';

double calculateBMI(int height, int weight) {
  return 703 * (weight / pow(height, 2));
}

Future<double> calculateBMIAsync(Dio dio) async {
  var result = await dio.get('https://jsonkeeper.com/b/AKFA');

  // Ensure we always get a Map<String, dynamic>
  Map<String, dynamic> data;
  if (result.data is String) {
    data = jsonDecode(result.data) as Map<String, dynamic>;
  } else {
    data = Map<String, dynamic>.from(result.data);
  }

  // Cast the list to List<int>
  var values = List<int>.from(data['Sergio Ramos']);
  return calculateBMI(values[0], values[1]);
}
