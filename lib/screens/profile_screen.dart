import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/bloc/logout/bloc/logout_bloc.dart';
import 'package:restaurant_app/login_screen.dart';
import 'package:restaurant_app/models/colors.dart';

// class MyProfile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LogoutBloc()..add(LogOut()),
//       child: ProfileScreen(),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(GetLoginData());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.color2,
                      )),
                  TextButton(onPressed: () {}, child: Text('Edit'))
                ]),
          ),
          SizedBox(
            height: 50,
          ),
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            print('Current state: ${state.state}');
            print('ProfileScreen - Current state: ${state.state}');
            print('ProfileScreen - userName: ${state.userName}');
            print('ProfileScreen - userMailAddress: ${state.userMailAddress}');
            print('ProfileScreen - profileImage: ${state.profileImage}');

            if (state.state == LoginScreenState.success) {
              print('Current state: ${state.state}');
              return Column(
                children: [
                  CircleAvatar(
                    // backgroundImage: NetworkImage(),
                    backgroundColor: AppColors.color1,
                    radius: 60.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    state.userMailAddress ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              );
            } else
              return Container();
          }),
          SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invite friends',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: BlocBuilder<LogoutBloc, LogoutState>(
                      builder: (context, state) {
                    if (state.state == LogoutScreenState.success) {
                      return Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Log out',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => MyLogin()));
                                    BlocProvider.of<LogoutBloc>(context)
                                        .add(LogOut());
                                  },
                                  icon: Icon(Icons.keyboard_arrow_right))
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  })),
            ],
          )
        ]),
      ),
    );
  }
}
