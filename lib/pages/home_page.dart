import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter_camera/pages/preview_page.dart';
import 'package:flutter_camera/pages/widget/attachment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? fileIncoming;
  final picker = ImagePicker();

  Future getFileFromGallery() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => fileIncoming = File(file.path));
    }
  }

  showPreview(file) async {
    File? arq = await Get.to(() => PreviewPage(file: file));

    if (arq != null) {
      setState(() => fileIncoming = arq);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envie seu Comprovante'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (fileIncoming != null) Attachment(file: fileIncoming!),
                ElevatedButton.icon(
                  onPressed: () => Get.to(
                    () => CameraCamera(onFile: (file) => showPreview(file)),
                  ),
                  icon: const Icon(Icons.camera_alt),
                  label: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Tire uma foto'),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      textStyle: const TextStyle(
                        fontSize: 18,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('ou'),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Selecione um arquivo'),
                  onPressed: () => getFileFromGallery(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
