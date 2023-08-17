import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/login/login_bloc.dart';
import 'package:restaurant_app/models/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          // BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          //   if (state.state == LoginScreenState.success) {
          //     return Column(
          //       children: [
          //         CircleAvatar(
          //           backgroundColor: AppColors.color1,
          //           radius: 60.0,
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Text(
          //           state.userName ?? '',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 30.0,
          //             color: AppColors.black,
          //           ),
          //         ),
          //         Text(
          //           state.userMailAddress ?? '',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 15.0,
          //             color: AppColors.grey,
          //           ),
          //         ),
          //       ],
          //     );
          //   } else
          //     return Container();
          // }),
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
                  child: Container(
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
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right))
                        ],
                      ))),
            ],
          )
        ]),
      ),
    );
  }
}
