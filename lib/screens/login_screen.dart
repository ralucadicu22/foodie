import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/screens/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.color2,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _pass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                    CreateAccountWithEmailAndPassword(
                      email: _email.text,
                      password: _pass.text,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color1,
                  minimumSize: Size(500, 40),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                    SignInWithEmailAndPassword(
                      email: _email.text,
                      password: _pass.text,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color1,
                  minimumSize: Size(500, 40),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'or',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LogInwithGoogle());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.google,
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Login with Google',
                            style: TextStyle(
                              color: AppColors.black,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginwithFacebook());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.facebook,
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Login with Facebook',
                            style: TextStyle(
                              color: AppColors.black,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.state == LoginScreenState.loading) {
                    CircularProgressIndicator();
                  } else if (state.state == LoginScreenState.error) {
                    Text('An error has occurred');
                  } else if (state.state == LoginScreenState.success) {
                    BlocProvider.of<LoginBloc>(context).add(GetLoginData());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyMain()));
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
