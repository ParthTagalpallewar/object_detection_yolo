import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:object_detection_yolo/ui/splash_screen.dart';

// class ImageUploadPage extends StatefulWidget {
//   @override
//   _ImageUploadPageState createState() => _ImageUploadPageState();
// }
//
// class _ImageUploadPageState extends State<ImageUploadPage> {
//   File? _image;
//
//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     } else {
//       print("No image selected");
//     }
//   }
//
//   // Function to upload the image
//   Future<void> _uploadImage() async {
//     if (_image == null) {
//       print("No image selected for upload");
//       return;
//     }
//
//     final uri = Uri.parse("http://192.168.154.44:8000/detect");
//     final request = http.MultipartRequest('POST', uri);
//
//     // Attach the file with the key 'file'
//     request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
//
//     try {
//       final response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         print("Response: $responseBody");
//       } else {
//         print("Failed to upload image: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Image Upload')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image != null
//                 ? Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover)
//                 : Text("No image selected"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text("Pick Image"),
//             ),
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: Text("Upload Image"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}
