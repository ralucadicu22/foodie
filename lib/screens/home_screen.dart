import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/home_screen/bloc/home_screen_bloc.dart';
import 'package:restaurant_app/models/buildScroll.dart';
import 'package:restaurant_app/models/navigation_bar.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeScreenBloc(), child: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
        if (state.state == HomeState.loading) {
          return CircularProgressIndicator();
        } else if (state.state == HomeState.loaded) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
                child: Container(
                    height: 150,
                    child: Container(
                        height: 150,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: PageController(initialPage: 0),
                            itemCount: state.nearbyRestaurants.length,
                            itemBuilder: (context, index) {
                              state.nearbyRestaurants[index];
                            })))),
            BuildScroll('Most Popular', state.hotandnew, () {}),
            BuildScroll('Meal Deals', state.deals, () {}),
            BuildScroll('Restaurants with delivery', state.delivery, () {}),
            BuildScroll('TakeAway Restaurants', state.takeaway, () {}),
          ]);
        } else if (state.state == HomeState.error) {
          Text('Facing errors trying to fetch data ');
        }
        return Container();
      }),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
