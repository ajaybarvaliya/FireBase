import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBoxDemo extends StatefulWidget {
  const ImageBoxDemo({Key? key}) : super(key: key);

  @override
  State<ImageBoxDemo> createState() => _ImageBoxDemoState();
}

class _ImageBoxDemoState extends State<ImageBoxDemo> {
  ImagePicker imagePicker = ImagePicker();

  File? image;

  List imageFileList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.camera);

                                  image = File(file!.path);
                                  setState(() {});

                                  print('PATH ${file.path}');

                                  imageFileList.add(image);
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.camera_alt),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);

                                  image = File(file!.path);
                                  setState(() {});

                                  print('PATH ${file.path}');

                                  imageFileList.add(image);
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.camera),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.camera_alt),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: imageFileList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.cyan,
                    child: Image.file(
                      imageFileList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
