import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/home_screen/bloc/home_screen_bloc.dart';
import 'package:restaurant_app/models/buildScroll.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/navigation_bar.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/models/restaurant_widget.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeScreenBloc()..add(FetchData()),
        child: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
        if (state.state == HomeState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == HomeState.loaded) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 150,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(initialPage: 0),
                  itemCount: state.nearbyRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.nearbyRestaurants[index];
                    return Container(
                      width: 300,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(restaurant.image_url),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            color: AppColors.black.withOpacity(0.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  restaurant.location.address1,
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            BuildScroll('Most Popular', state.hotandnew, () {}),
            BuildScroll('Meal Deals', state.deals, () {}),
            BuildScroll('Restaurants with delivery', state.delivery, () {}),
            BuildScroll('TakeAway Restaurants', state.takeaway, () {}),
          ]);
        } else if (state.state == HomeState.error) {
          return Text('Facing errors trying to fetch data ');
        } else {
          return Container();
        }
      }),
    );
  }
}
