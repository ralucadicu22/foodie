import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 193, 7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 241, 145, 10),
        title: Text(
          'Discover your food',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.food_bank_outlined),
            onPressed: () {},
            color: Colors.black,
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage('assets/food-1.jpg'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(.7),
              ),
              Text(
                'The secret of success in life is to eat what you like.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black87,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 115,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color.fromARGB(255, 241, 145, 10),
                ),
                child: Image.asset('assets/food-2.jpg',
                    width: 150,
                    height: 115,
                    fit: BoxFit.cover,
                    opacity: AlwaysStoppedAnimation(.5)),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.start,
                ),
                label: Text('Get started'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
