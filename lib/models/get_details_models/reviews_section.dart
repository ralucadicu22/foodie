import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/get_details/bloc/get_details_bloc.dart';
import 'package:restaurant_app/models/colors.dart';
import 'package:restaurant_app/models/get_details_models/reviews.dart';
import 'package:restaurant_app/models/star_rating.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;

  ReviewsSection({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: reviews.map((review) {
            String shortText = review.textReview.substring(0, 88);
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 30,
                        backgroundImage:
                            review.userReview.imageUrlUser != null &&
                                    review.userReview.imageUrlUser.isNotEmpty
                                ? NetworkImage(review.userReview.imageUrlUser)
                                : null,
                      ),
                      VerticalDivider(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userReview.nameUser,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.black,
                            ),
                          ),
                          Row(
                            children: [
                              StarRating(
                                rating: review.ratingReview.toDouble(),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    review.expanded ? review.textReview : shortText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<GetDetailsBloc>(context).add(
                      ReadMoreReviews(review: review),
                    );
                  },
                  child: Text(
                    review.expanded ? 'Read Less' : 'Read More',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
