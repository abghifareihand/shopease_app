import 'package:flutter/material.dart';
import 'package:shopease_app/core/constants/colors.dart';

class TitleContent extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const TitleContent({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          InkWell(
            onTap: onSeeAllTap,
            child: Text(
              'View All',
              style:
                  primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ),
        ],
      ),
    );
  }
}
