// ignore_for_file: avoid_print
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final imageRef = FirebaseStorage.instance.ref().child("images");

class ImageStorage {
  // Choose image from gallery
  Future<XFile?> pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image;
  }
  // Save avatars to database
  Future<String> uploadAvatarToStorage(XFile image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final bytes = await image.readAsBytes(); 
    UploadTask uploadTask = storageReference.putData(bytes);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('Upload image to storage successfully'));
    String imgUrl = await taskSnapshot.ref.getDownloadURL(); 
    return imgUrl;
  }
  // Save product ti th database
  Future<String> uploadProductImageToStorage(XFile image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final bytes = await image.readAsBytes(); 
    UploadTask uploadTask = storageReference.putData(bytes);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('Upload image to storage successfully'));
    String imgUrl = await taskSnapshot.ref.getDownloadURL(); 
    return imgUrl;
  }
}