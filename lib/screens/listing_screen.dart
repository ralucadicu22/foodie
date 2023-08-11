import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/listing/bloc/listing_bloc.dart';
import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class MyListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListingBloc()..add(LoadAllRestaurants()),
      child: ListingScreen(),
    );
  }
}

class ListingScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.food),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHome()),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              ),
                              label: Text(''),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Restaurants',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          BlocBuilder<ListingBloc, ListingState>(
            builder: (context, state) {
              if (state is ListingLoadingState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ListingLoadedState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = state.categories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              category.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: category.restaurants.map((restaurant) {
                              return ListContainer(restaurant);
                            }).toList(),
                          ),
                        ],
                      );
                    },
                    childCount: state.categories.length,
                  ),
                );
              } else if (state is ListingErrorState) {
                return SliverToBoxAdapter(
                  child: Text('Error loading data'),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
