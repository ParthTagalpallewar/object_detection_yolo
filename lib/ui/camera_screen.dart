import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:object_detection_yolo/utils.dart';
import 'dart:convert';

import '../models/cart_item.dart';
import '../models/shooping_cart.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;

  // Function to pick an image from the gallery
  Future<void> _pickImage(bool isGallery) async {
    final picker = ImagePicker();

    final pickedFile;

    if(isGallery){
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage();
      });
    } else {
      showToast(context, "No image selected for upload");
    }
  }

  // Function to upload the image
  Future<void> _uploadImage() async {
    if (_image == null) {
      showToast(context, "No image selected for upload");
      return;
    }

    final uri = Uri.parse("http://192.168.154.44:8000/detect");
    final request = http.MultipartRequest('POST', uri);

    // Attach the file with the key 'file'
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedJson = json.decode(responseBody);

        final itemJson = decodedJson['detections'][0] as Map<String, dynamic>;
        final shoppingCartItem = ShoppingCartItem.fromJson(itemJson, _image!.path);
        setState(() {

          shoppingCart.add(shoppingCartItem);
        });

        showToast(context, shoppingCartItem.label + " is Added");



        print("Response Body: $responseBody");

        Navigator.pop(context);

      } else {
        showToast(context, "Failed to upload image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Upload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover)
                : Text("No image selected"),
          ],
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    'Open Camera',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: (){ _pickImage(false);},

                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    'Open Gallery',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: (){ _pickImage(true);},

                ),
              ),
            ],
          ),
      ),
    );
  }
}
