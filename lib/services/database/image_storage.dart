// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final imageRef = FirebaseStorage.instance.ref().child("images");

class ImageStorage {

  Future<XFile?> pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image;
  }
  
  Future<File> toXFile(XFile xFile) async {
    final bytes = await xFile.readAsBytes(); 
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${xFile.name}');
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  Future<String> uploadImageToStorage(XFile image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final bytes = await image.readAsBytes(); 
    UploadTask uploadTask = storageReference.putData(bytes);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('Upload image to storage successfully'));
    String imgUrl = await taskSnapshot.ref.getDownloadURL(); 
    return imgUrl;
  }
}