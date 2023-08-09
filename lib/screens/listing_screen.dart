import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/listing/bloc/listing_bloc.dart';
import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class MyListingScreen extends StatelessWidget {
  final String initialCategory;
  MyListingScreen({required this.initialCategory});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListingBloc()..add(LoadAllRestaurants()),
      child: ListingScreen(
        initialCategory: initialCategory,
      ),
    );
  }
}

class ListingScreen extends StatelessWidget {
  final String initialCategory;
  final ScrollController _scrollController = ScrollController();

  ListingScreen({required this.initialCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            key: Key(initialCategory),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Text(
                'Restaurants list',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<ListingBloc, ListingState>(
                  builder: (context, state) {
                    if (state.state == ListingStateEnum.loaded) {
                      return Row(
                        children: state.categories.map((category) {
                          return InkWell(
                            onTap: () {
                              _scrollController.animateTo(
                                _scrollController.position.minScrollExtent +
                                    state.categories.indexWhere((category) =>
                                            category.title == initialCategory) *
                                        2350.0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              child: Text(
                                category.title,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else if (state.state == ListingStateEnum.error) {
                      return Text('Error loading data');
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ListingBloc, ListingState>(
            builder: (context, state) {
              if (state.state == ListingStateEnum.loading) {
                return SliverToBoxAdapter(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              } else if (state.state == ListingStateEnum.loaded) {
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
              } else if (state == ListingStateEnum.error) {
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
