import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
    'Given height and weight when calculateBMI is invoked then correct BMI is returned',
    () {
      // arrange
      final height = 70; // inches
      final weight = 150; // lbs

      // act
      final bmi = calculateBMI(height, weight);

      // assert
      expect(bmi, closeTo(21.52, 0.01));
    },
  );

  test(
    'Given url when calculateBMIAsync invoked then correct BMI is returned',
    () async {
      // arrange
      final dioMock = DioMock();

      when(() => dioMock.get('https://jsonkeeper.com/b/AKFA')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: 'https://jsonkeeper.com/b/AKFA'),
          // Returning JSON string so it mimics a real API response
          data: jsonEncode({
            "Sergio Ramos": [72, 165],
          }),
        ),
      );

      // act
      var result = await calculateBMIAsync(dioMock);

      // assert
      expect(result, closeTo(22.37, 0.01)); // 703 * (165 / 72^2)
    },
  );
}
