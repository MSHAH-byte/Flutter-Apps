import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';

/// Encode image file to Base64 string
Future<String> encodeImageFileToBase64(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  return base64Encode(bytes);
}

/// Decode Base64 string to Image widget
Image decodeBase64ToImage(String base64String, {BoxFit fit = BoxFit.cover}) {
  return Image.memory(base64Decode(base64String), fit: fit);
}

/// Decode Base64 string to raw bytes
Uint8List decodeBase64ToBytes(String base64String) {
  return base64Decode(base64String);
}

/// Universal decoder: works for Base64 or URL
Image decodeImageFromString(String? imageString, {BoxFit fit = BoxFit.cover}) {
  if (imageString == null || imageString.isEmpty) {
    return Image.asset("assets/placeholder.png", fit: fit);
  }

  // If it looks like a URL, load with NetworkImage
  if (imageString.startsWith("http://") || imageString.startsWith("https://")) {
    return Image.network(imageString, fit: fit);
  }

  // Otherwise, try Base64 decode
  try {
    return Image.memory(base64Decode(imageString), fit: fit);
  } catch (e) {
    debugPrint("Error decoding Base64: $e");
    return Image.asset("assets/placeholder.png", fit: fit);
  }
}
