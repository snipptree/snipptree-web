import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/usecases/home_usecase.dart';
import 'package:snippet/ui/home/home_controller.dart';

class GoogleSignInButton extends StatefulWidget {
  final HomeController controller;

  const GoogleSignInButton({super.key, required this.controller});

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.googleSignIn.value = GoogleSignIn(
      clientId: AppConstants.googleSignInOAuthClientId,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    _signInSilently(); // Try silent sign-in on init
  }

  // Attempt silent sign-in
  Future<void> _signInSilently() async {
    try {
      widget.controller.gUser.value = await widget.controller.googleSignIn.value?.signInSilently();
      if (widget.controller.gUser.value != null && widget.controller.gUser.value!.email.isNotEmpty) {
        HomeUseCase useCase = HomeUseCase();
        User user = useCase.getUserData(widget.controller.gUser.value);
        widget.controller.authenticateUser(user);
      }
    } catch (error) {
      // Handle sign-in silently errors
      debugPrint('Error during silent sign-in: $error');
    }
  }

  // Sign-in with Google (regular flow)
  Future<void> signInWithGoogle() async {
    HomeUseCase useCase = HomeUseCase();
    try {
      widget.controller.gUser.value = await widget.controller.googleSignIn.value?.signIn();
      if (widget.controller.gUser.value != null && widget.controller.gUser.value?.email.isNotEmpty == true) {
        User user = useCase.getUserData(widget.controller.gUser.value);
        widget.controller.authenticateUser(user);
      }
    } catch (error) {
      // Handle sign-in errors
      debugPrint('Error during Google sign-in: $error');
      Util().showToast(title: "Google sign-in failed.", subTitle: "Please try again.", type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
      ),
      onPressed: signInWithGoogle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Image.asset(
              'assets/images/google_logo.png', // Add a Google logo in your assets
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
