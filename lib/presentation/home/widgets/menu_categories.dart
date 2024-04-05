import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/core/components/loading.dart';
import 'package:shopease_app/core/components/spaces.dart';
import 'package:shopease_app/core/constants/colors.dart';
import 'package:shopease_app/core/constants/variables.dart';
import 'package:shopease_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:shopease_app/presentation/home/widgets/title_content.dart';

class MenuCategories extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  const MenuCategories({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(
          title: title,
          onSeeAllTap: onSeeAllTap,
        ),
        const SpaceHeight(10),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const LoadingSpinkitColor();
              },
              loaded: (categoryResponse) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      ...categoryResponse.data!.map(
                        (category) => Flexible(
                          child: CategoryCard(
                            imagePath:
                                '${Variables.baseUrl}/${category.image!}',
                            label: category.name!,
                            onPressed: () {
                              log(category.name!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                imagePath,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              label,
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
