import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopease_app/data/models/response/city_response_model.dart';
import 'package:shopease_app/data/models/response/province_response_model.dart';
import 'package:shopease_app/data/models/response/subdistrict_response_model.dart';
import 'package:shopease_app/presentation/address/bloc/city/city_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/province/province_bloc.dart';
import 'package:shopease_app/presentation/address/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:shopease_app/presentation/home/widgets/location_selector.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Province? selectedProvince;
  City? selectedCity;
  Subdistrict? selectedSubdistrict;

  @override
  void initState() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 40),
          CustomDropdown(
            hintText: 'Provinsi',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<ProvinceBloc, ProvinceState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        loaded: (province) {
                          final prov = province.rajaongkir!.results!;
                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: prov.length,
                                    itemBuilder: (context, index) {
                                      final province = prov[index];
                                      return RadioListTile(
                                        title: Text(province.province!),
                                        value: province,
                                        groupValue: selectedProvince,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              selectedProvince =
                                                  value as Province;
                                              selectedCity = null;
                                              selectedSubdistrict = null;
                                              context.read<CityBloc>().add(
                                                  CityEvent.getCity(
                                                      selectedProvince!
                                                          .provinceId!));
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          CustomDropdown(
            hintText: 'Kota',
            onTap: () {
              if (selectedProvince != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocBuilder<CityBloc, CityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          loaded: (city) {
                            final kota = city.rajaongkir!.results!;
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: kota.length,
                                      itemBuilder: (context, index) {
                                        final city = kota[index];
                                        return RadioListTile(
                                          title: Text(city.cityName!),
                                          value: city,
                                          groupValue: selectedCity,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                selectedCity = value as City;
                                                selectedSubdistrict = null;
                                                context
                                                    .read<SubdistrictBloc>()
                                                    .add(SubdistrictEvent
                                                        .getSubdistrict(
                                                            selectedCity!
                                                                .cityId!));
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else {
                // Tampilkan pesan bahwa Province belum dipilih
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a province first.'),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          CustomDropdown(
            hintText: 'Kecamatan',
            onTap: () {
              if (selectedCity != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocBuilder<SubdistrictBloc, SubdistrictState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          loaded: (subdistrict) {
                            final kec = subdistrict.rajaongkir!.results!;
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: kec.length,
                                      itemBuilder: (context, index) {
                                        final subdistrict = kec[index];
                                        return RadioListTile(
                                          title: Text(
                                              subdistrict.subdistrictName!),
                                          value: subdistrict,
                                          groupValue: selectedSubdistrict,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                selectedSubdistrict =
                                                    value as Subdistrict;
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else {
                // Tampilkan pesan bahwa Kota belum dipilih
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a city first.'),
                  ),
                );
              }
            },
          ),
          Text('${selectedProvince?.province}'),
          Text('${selectedCity?.cityName}'),
          Text('${selectedSubdistrict?.subdistrictName}'),
        ],
      ),
    );
  }
}
