import 'dart:ui';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reel_feel/authentication/login_screen.dart';
import 'package:reel_feel/global.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController{
  static AuthenticationController instanceAuth= Get.find();

   late Rx<File?>_pickedFile;
   File? get profileImage=> _pickedFile.value;

     void chooseImageFromGallary() async
     {
        final pickedImageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
        if(pickedImageFile!=null){
           Get.snackbar(
               "Profile Image",
               "you have successfully captured your profile image with Phone camera"
           );
        }
        _pickedFile = Rx<File?>(File(pickedImageFile!.path));
     }

     void captureImageWithCamera() async
   {
     final pickedImageFile= await ImagePicker().pickImage(source: ImageSource.camera);
     if(pickedImageFile!=null){
       Get.snackbar(
           "Profile Image",
           "you have successfully selected your profile image"
       );
     }
     _pickedFile = Rx<File?>(File(pickedImageFile!.path));


   }

    void createAccountForNewUser(File imageFile,String userName,String userEmail,String userPassword) async {
        try{
          //1. create user in the firebase authentication
          UserCredential credential= await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: userEmail,
              password: userPassword);

          //2.save the user profile image to firebase storage
          String imageDownloaodUrl= await uploadImageToStoroage(imageFile);
          //3. save to the firebase database

          userModel.User user=userModel.User(
            name: userName,
            email: userEmail,
            image: imageDownloaodUrl,
            uid: credential.user!.uid,
          );
          await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
        }
        catch(error){
           Get.snackbar("Account Creation Unsuccessful", "Error Occured while creating account. Try again");
             showProgressBar=false;
            Get.to(LoginScreen());
        }
    }

  Future<String> uploadImageToStoroage(File imageFile) async {
       Reference reference= FirebaseStorage.instance.ref()
           .child("Profile Images")
           .child(FirebaseAuth.instance.currentUser!.uid);
       UploadTask uploadTask=reference.putFile(imageFile);
       TaskSnapshot taskSnapshot= await uploadTask;

       String downloadUrlOfUploadImage= await taskSnapshot.ref.getDownloadURL();
           return downloadUrlOfUploadImage;
  }
}