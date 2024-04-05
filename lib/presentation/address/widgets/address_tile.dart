import 'package:flutter/material.dart';
import 'package:shopease_app/core/constants/colors.dart';
import 'package:shopease_app/data/models/response/address_response_model.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final VoidCallback onTap;
  final bool isSelected;
  const AddressTile({
    super.key,
    required this.address,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    address.phone!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    address.fullAddress!,
                    style: greyTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
