import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reel_feel/authentication/authentication_controller.dart';
import 'package:reel_feel/authentication/login_screen.dart';
import 'package:reel_feel/widgets/input_text_widgets.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../global.dart';

class RegistrationScreen extends StatefulWidget {


  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

   var authenticationController= AuthenticationController.instanceAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 110,
                ),

                Text(
                  'Create Account',
                  style: GoogleFonts.acme(
                    fontSize: 34,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'To get started now',
                  style: GoogleFonts.acme(
                    fontSize: 34,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 15,),
                // profile avatar
         GestureDetector(
          onTap: (){
            // allow user to choose image
             authenticationController.captureImageWithCamera();
          },
          child:  const CircleAvatar(
            backgroundColor: Colors.white,
             radius: 80,
              backgroundImage:AssetImage("images/profile-icon-png-893.png"),
            ),
          ),

                const SizedBox(
                  height: 30,
                ),
                // username input
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: userNameTextEditingController,
                    lableString: "Username",
                    iconData: Icons.person_outline,
                    isObscure: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //email input
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: emailTextEditingController,
                    lableString: "Email",
                    iconData: Icons.email_outlined,
                    isObscure: false,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // password input
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: emailTextEditingController,
                    lableString: "Password",
                    iconData: Icons.lock_outline,
                    isObscure: true,
                  ),
                ),
               const SizedBox(
                  height: 30,
                ),
                // login button
                // not have an account, signup now button
                showProgressBar==false?
                Column(
                  children: [
                    // sign up button
                    Container(
                      width: MediaQuery.of(context).size.width - 38,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: (){

                         if(authenticationController.profileImage!=null
                             && userNameTextEditingController.text.isNotEmpty
                             && emailTextEditingController.text.isNotEmpty
                             && passwordTextEditingController.text.isNotEmpty) {
                             setState(() {
                               showProgressBar=true;
                              });
                           // create a account for user
                           authenticationController.createAccountForNewUser(
                             authenticationController.profileImage!,
                             userNameTextEditingController.text,
                             emailTextEditingController.text ,
                             passwordTextEditingController.text,
                           );
                         }

                        },
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,

                            ),
                          ),
                        ),
                      ),

                    ),
                    const SizedBox(height: 15,),
                    // not have an acount, signup now button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have account ?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(LoginScreen());
                          },
                          child: const Text(
                            "Login Now",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ):Container(
                  child: const SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                      Colors.red,
                      Colors.amber,
                      Colors.purpleAccent,
                    ],
                    animationDuration: 3,
                    backColor: Colors.white38,
                  ),
                ),
      ],
            )),
      ));

  }
}
