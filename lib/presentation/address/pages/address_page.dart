import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/core/components/buttons.dart';
import 'package:shopease_app/core/components/loading.dart';
import 'package:shopease_app/core/components/spaces.dart';
import 'package:shopease_app/core/constants/colors.dart';
import 'package:shopease_app/presentation/address/bloc/address/address_bloc.dart';
import 'package:shopease_app/presentation/address/pages/add_address_page.dart';
import 'package:shopease_app/presentation/address/widgets/address_tile.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(const AddressEvent.getAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          context.read<AddressBloc>().add(const AddressEvent.getAddress());
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Daftar Alamat',
              style: blackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const SpaceHeight(20.0),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const LoadingSpinkitColor();
                  },
                  loaded: (addressResponse) {
                    final addresses = addressResponse.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addresses.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 2,
                          color: AppColors.grey.withOpacity(0.2),
                        );
                      },
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return AddressTile(
                          address: address,
                          isSelected: false,
                          onTap: () {},
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SpaceHeight(40.0),
            Button.outlined(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAddressPage(),
                  ),
                );
              },
              label: 'Tambah Alamat',
            ),
          ],
        ),
      ),
    );
  }
}
