import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/add_address/add_address_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/address/address_bloc.dart';
import 'package:shopease_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:shopease_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:shopease_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:shopease_app/presentation/dashboard/dashboard_page.dart';
import 'package:shopease_app/presentation/address/bloc/city/city_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/province/province_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:shopease_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:shopease_app/presentation/home/bloc/product/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(),
        ),
        BlocProvider(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => CityBloc(),
        ),
        BlocProvider(
          create: (context) => SubdistrictBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5D87FF)),
          useMaterial3: true,
        ),
        home: const DashboardPage(
          currentTab: 0,
        ),
      ),
    );
  }
}
