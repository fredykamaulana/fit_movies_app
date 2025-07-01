import 'package:fit_movies_app/controllers/auth_controller/auth_controller.dart';
import 'package:fit_movies_app/data/auth/firebase_auth_service.dart';
import 'package:fit_movies_app/navigations/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController psswdController = TextEditingController();

  AuthController authController =
      Get.put(AuthController(Get.put(FirebaseAuthService())));

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Masuk dah',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox.square(dimension: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukan Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox.square(dimension: 16),
              TextField(
                controller: psswdController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukan Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )),
              ),
              SizedBox.square(dimension: 16),
              ElevatedButton(
                  onPressed: () async {
                    final result = await authController.signIn(
                        emailController.text, psswdController.text);

                    if (mounted) {
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Sukses masuk sebagai ${result.email}')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Masuk gagal')));
                      }
                    }
                    emailController.clear();
                    psswdController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Masuk'),
                    ),
                  )),
              SizedBox.square(dimension: 16),
              Text('Atau'),
              SizedBox.square(dimension: 16),
              ElevatedButton(
                  onPressed: () async {
                    final result = await authController.signInWithGoogle();

                    if (mounted) {
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Sukses masuk sebagai ${result.user?.email}')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Masuk gagal')));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Masuk dengan Google'),
                    ),
                  )),
              SizedBox.square(dimension: 32),
              Row(
                children: [
                  Text('Belum punya akun?'),
                  SizedBox.square(dimension: 4),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, NavigationRoutes.register.name);
                      },
                      child: Text('Daftar'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
