import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/core/components/loading.dart';
import 'package:shopease_app/core/constants/colors.dart';
import 'package:shopease_app/core/constants/formatter.dart';
import 'package:shopease_app/core/constants/images.dart';
import 'package:shopease_app/data/models/response/product_response_model.dart';
import 'package:shopease_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:shopease_app/presentation/home/widgets/title_content.dart';

import '../../../../core/components/spaces.dart';

class ListProducts extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const ListProducts({
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
        const SpaceHeight(10.0),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const LoadingSpinkitColor();
              },
              loaded: (productResponse) {
                final products = productResponse.data!.data!;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.70,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductCard(
                    data: products[index],
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

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    data.image!,
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.placeholder,
                      width: double.infinity,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(5.0),
                //   child: Image.network(
                //     data.image!.contains('http')
                //         ? data.image!
                //         : '${Variables.baseUrl}/${data.image}',
                //     width: double.infinity,
                //     height: 120.0,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SpaceHeight(14.0),
                Flexible(
                  child: Text(
                    data.name!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  priceFormat(data.price),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  // context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
                },
                icon: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.2),
                        blurRadius: 1.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
