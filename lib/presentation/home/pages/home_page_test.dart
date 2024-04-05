import 'package:flutter/material.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({Key? key});

  // Membuat variabel untuk menyimpan nilai provinsi yang dipilih
  static int? selectedProvinsi;

  void _showProvinsiList(
      BuildContext context, TextEditingController controller) {
    Map<int, String> provinsiMap = {
      1: 'DKI Jakarta',
      2: 'Jawa Barat',
      3: 'Jawa Timur',
      4: 'Jawa Tengah',
    };

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provinsiMap.length,
                      itemBuilder: (BuildContext context, int index) {
                        int id = provinsiMap.keys.elementAt(index);
                        String provinsiName = provinsiMap[id]!;
                        return ListTile(
                          title: Text(provinsiName),
                          trailing: Radio(
                            value: id,
                            groupValue: selectedProvinsi,
                            onChanged: (int? value) {
                              setState(() {
                                selectedProvinsi = value;
                              });
                              debugPrint('Selected ID: $value');
                            },
                          ),
                          onTap: () {
                            setState(() {
                              selectedProvinsi = id;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedProvinsi != null) {
                        controller.text = provinsiMap[selectedProvinsi!]!;
                        Navigator.pop(context); // Tutup bottom sheet
                      }
                    },
                    child: const Text('Pilih'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 40),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
              hintText: 'Province',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 12.0,
              ),
            ),
            onTap: () {
              _showProvinsiList(context, controller);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
