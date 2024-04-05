// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopease_app/data/models/city_response_model.dart';
// import 'package:shopease_app/data/models/province_response_model.dart';
// import 'package:shopease_app/data/models/subdistrict_response_model.dart';
// import 'package:shopease_app/presentation/home/bloc/city/city_bloc.dart';
// import 'package:shopease_app/presentation/home/bloc/province/province_bloc.dart';
// import 'package:shopease_app/presentation/home/bloc/subdistrict/subdistrict_bloc.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Province? selectedProvince;
//   final TextEditingController _provinceController = TextEditingController();

//   City? selectedCity;
//   final TextEditingController _cityController = TextEditingController();

//   Subdistrict? selectedSubdistrict;
//   final TextEditingController _subdistrictController = TextEditingController();

//   @override
//   void initState() {
//     context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           const SizedBox(height: 40),

//           /// Province
//           TextFormField(
//             controller: _provinceController,
//             readOnly: true,
//             decoration: InputDecoration(
//               suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
//               hintText: 'Province',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 14.0,
//                 horizontal: 12.0,
//               ),
//             ),
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return BlocBuilder<ProvinceBloc, ProvinceState>(
//                     builder: (context, state) {
//                       return state.maybeWhen(
//                         orElse: () {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         },
//                         loaded: (province) {
//                           final prov = province.rajaongkir!.results!;
//                           return Container(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Expanded(
//                                   child: ListView.builder(
//                                     itemCount: prov.length,
//                                     itemBuilder: (context, index) {
//                                       final province = prov[index];
//                                       return RadioListTile(
//                                         title: Text(province.province!),
//                                         value: province,
//                                         groupValue: selectedProvince,
//                                         onChanged: (value) {
//                                           setState(
//                                             () {
//                                               selectedProvince =
//                                                   value as Province;
//                                               _provinceController.text =
//                                                   province.province!;
//                                               _cityController.text = '';
//                                               _subdistrictController.text = '';
//                                               context.read<CityBloc>().add(
//                                                   CityEvent.getCity(
//                                                       selectedProvince!
//                                                           .provinceId!));
//                                             },
//                                           );
//                                           Navigator.pop(context);
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//           const SizedBox(height: 20),

//           /// City
//           TextFormField(
//             controller: _cityController,
//             readOnly: true,
//             decoration: InputDecoration(
//               suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
//               hintText: 'City',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 14.0,
//                 horizontal: 12.0,
//               ),
//             ),
//             onTap: () {
//               if (selectedProvince != null) {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return BlocBuilder<CityBloc, CityState>(
//                       builder: (context, state) {
//                         return state.maybeWhen(
//                           orElse: () {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           },
//                           loaded: (city) {
//                             final kota = city.rajaongkir!.results!;
//                             return Container(
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: kota.length,
//                                       itemBuilder: (context, index) {
//                                         final city = kota[index];
//                                         return RadioListTile(
//                                           title: Text(city.cityName!),
//                                           value: city,
//                                           groupValue: selectedCity,
//                                           onChanged: (value) {
//                                             setState(
//                                               () {
//                                                 selectedCity = value as City;
//                                                 _cityController.text =
//                                                     city.cityName!;
//                                                 _subdistrictController.text =
//                                                     '';
//                                                 context
//                                                     .read<SubdistrictBloc>()
//                                                     .add(SubdistrictEvent
//                                                         .getSubdistrict(
//                                                             selectedCity!
//                                                                 .cityId!));
//                                               },
//                                             );
//                                             Navigator.pop(context);
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 );
//               } else {
//                 // Tampilkan pesan bahwa Province belum dipilih
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Please select a province first.'),
//                   ),
//                 );
//               }
//             },
//           ),

//           const SizedBox(height: 20),

//           /// Subdistrict
//           TextFormField(
//             controller: _subdistrictController,
//             readOnly: true,
//             decoration: InputDecoration(
//               suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
//               hintText: 'Subdistrict',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 14.0,
//                 horizontal: 12.0,
//               ),
//             ),
//             onTap: () {
//               if (selectedCity != null) {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return BlocBuilder<SubdistrictBloc, SubdistrictState>(
//                       builder: (context, state) {
//                         return state.maybeWhen(
//                           orElse: () {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           },
//                           loaded: (subdistrict) {
//                             final kec = subdistrict.rajaongkir!.results!;
//                             return Container(
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: kec.length,
//                                       itemBuilder: (context, index) {
//                                         final subdistrict = kec[index];
//                                         return RadioListTile(
//                                           title: Text(
//                                               subdistrict.subdistrictName!),
//                                           value: subdistrict,
//                                           groupValue: selectedSubdistrict,
//                                           onChanged: (value) {
//                                             setState(
//                                               () {
//                                                 selectedSubdistrict =
//                                                     value as Subdistrict;
//                                                 _subdistrictController.text =
//                                                     subdistrict
//                                                         .subdistrictName!;
//                                               },
//                                             );
//                                             Navigator.pop(context);
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 );
//               } else {
//                 // Tampilkan pesan bahwa City belum dipilih
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Please select a city first.'),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
