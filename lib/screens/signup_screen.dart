import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/resources/auth_method.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/utils.dart';
import 'package:instagram_app/widgets/text_field_input.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List imageUrl = await pickImage(ImageSource.gallery);
    setState(() {
      _image = imageUrl;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      //get a snackbar
      showSnackBar(res, context);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //Logo
              SvgPicture.asset(
                'assets/instagramLogo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 40,
              ),
              //Add image field////////////////////////////
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0="),
                        ),
                  Positioned(
                    bottom: -10,
                    right: -12,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Text field for username////////////////////
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Username",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              //Text field for email///////////////////////
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              //Text field for password////////////////////
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 10),
              //Submit button//////////////////////////////
              InkWell(
                onTap: signUpUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : const Text('Sign Up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(child: Container(), flex: 2),
              //Transition to Signup page//////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('ALrady have an account?'),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
