import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/listing/bloc/listing_bloc.dart';
import 'package:restaurant_app/models/assets.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/list_container.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class MyListingScreen extends StatelessWidget {
  final String type;
  const MyListingScreen({this.type = ''});
  @override
  @override
  Widget build(BuildContext context) {
    if (type.isEmpty) {
      Navigator.pop(context);
    }
    return BlocProvider(
      create: (context) => ListingBloc(type: type)..add(LoadAllRestaurants()),
      child: ListingScreen(
        type: type,
      ),
    );
  }
}

class ListingScreen extends StatefulWidget {
  final String type;
  ListingScreen({
    required this.type,
  });
  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !context.read<ListingBloc>().state.hasReachedMax) {
        context.read<ListingBloc>().add(LoadAllRestaurants());
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoScrollbar(
      thickness: 8.0,
      child: CustomScrollView(
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
                              label: Text('Home Screen'),
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
              if (state.state == ListingScreenState.loading &&
                  state.page == 0) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ListingScreenState.loaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListContainer(state.result[index]);
                    },
                    childCount: state.result.length,
                  ),
                );
              } else if (state.state == ListingScreenState.error) {
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
    ));
  }
}
