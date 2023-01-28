import 'dart:io';

import 'package:cat_dog/constant/colors.dart';
import 'package:cat_dog/constant/images.dart';
import 'package:cat_dog/widgets/homescreen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File? _image;
  List? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classfiyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  closeModel() async {
    await Tflite.close();
  }

  @override
  void dispose() {
    super.dispose();
    closeModel();
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });

    classfiyImage(_image!);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });

    classfiyImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color3B,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 85.h,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Cat OR Dog',
                  style: TextStyle(
                    color: AppColors.color54,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Detect Dogs and Cats",
                  style: TextStyle(
                    color: AppColors.color6F,
                    fontSize: 20.0.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: _loading
                    ? Container(
                        width: 350.w,
                        child: Column(
                          children: [
                            Image.asset(
                              AppImages.home,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              height: 250.h,
                              child: Image.file(_image! as File),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _output != null
                                ? Text(
                                    "${_output![0]['label']}",
                                    style: TextStyle(
                                      color: AppColors.color54,
                                      fontSize: 20.0.sp,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Button(
                      onTap: () {
                        if (_loading == false) {
                          setState(() {
                            _loading = true;
                          });
                        }
                        pickImage();
                      },
                      text: 'Take a photo',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Button(
                        onTap: () {
                          if (_loading == false) {
                            setState(() {
                              _loading = true;
                            });
                          }
                          pickGalleryImage();
                        },
                        text: 'Gallery'),
                    SizedBox(
                      height: 30,
                    ),
                    Button(
                        onTap: () {
                          setState(() {
                            _loading = true;
                          });
                        },
                        text: 'Reset'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
