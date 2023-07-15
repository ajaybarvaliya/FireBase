import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({super.key});

  @override
  State<ImagePickerDemo> createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  ImagePicker imagePicker = ImagePicker();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                XFile? file =
                    //    await imagePicker.pickImage(source: ImageSource.camera);
                    await imagePicker.pickImage(source: ImageSource.gallery);

                image = File(file!.path);
                setState(() {});

                print('PATH ${file.path}');
              },
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(
                          Icons.camera,
                          size: 50,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
