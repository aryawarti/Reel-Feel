import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reel_feel/authentication/registrationScreen.dart';
import 'package:reel_feel/widgets/input_text_widgets.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Image.asset(
              'images/img.png',
              width: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome',
              style: GoogleFonts.acme(
                fontSize: 34,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Glad to see you!',
              style: GoogleFonts.acme(
                fontSize: 34,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              height: 30,
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
            SizedBox(
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
            SizedBox(
              height: 30,
            ),
            // login button
            // not have an acount, signup now button
            showProgressBar==false?
            Column(
              children: [
                // login
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
                      setState(() {
                        showProgressBar=true;
                      });
                      // login user
                    },
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 15,),
                // not have an acount, signup now button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an Account ?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(RegistrationScreen());
                      },
                      child: const Text(
                        "SignUp Now",
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
      ),
    );
  }
}
