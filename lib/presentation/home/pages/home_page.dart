import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/core/components/spaces.dart';
import 'package:shopease_app/core/constants/colors.dart';
import 'package:shopease_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:shopease_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:shopease_app/presentation/home/widgets/banner_slider.dart';
import 'package:shopease_app/presentation/home/widgets/list_products.dart';
import 'package:shopease_app/presentation/home/widgets/menu_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getProducts());
    context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Shop Ease',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
        actions: [
          /// Cart
          Stack(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    '5',
                    style: whiteTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Notification
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const BannerSlider(),
          MenuCategories(
            title: 'Categories',
            onSeeAllTap: () {},
          ),
          const SpaceHeight(20.0),
          ListProducts(
            title: 'Products',
            onSeeAllTap: () {},
          ),
        ],
      ),
    );
  }
}
