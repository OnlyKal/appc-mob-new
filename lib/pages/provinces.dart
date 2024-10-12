import 'package:appc/func/color.dart';
import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvincesList extends StatefulWidget {
  const ProvincesList({super.key});

  @override
  _ProvincesListState createState() => _ProvincesListState();
}

class _ProvincesListState extends State<ProvincesList> {
  List _provinces = [];

  @override
  void initState() {
    getProvices().then((allprovinces) {
      if (allprovinces != null) {
        setState(() => _provinces = allprovinces.toList());
      }
    });
    super.initState();
  }

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    final List filteredProvinces = _provinces
        .where((province) =>
            province['name']
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            province['old_name']
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            province['iso'].toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goTo(context, const SignIn()),
            icon: const Icon(CupertinoIcons.back)),
        title: Text(
          lngx.trans("province_list"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: _provinces.isEmpty
          ? loading(context)
          : SingleChildScrollView(
              child: SizedBox(
                height: fullHeight(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: lngx.trans("search_province"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(CupertinoIcons.search)),
                        onChanged: (text) {
                          setState(() {
                            _searchText = text;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredProvinces.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => goTo(context,
                                SignUp(province: filteredProvinces[index])),
                            child: ListTile(
                              title: Text(
                                filteredProvinces[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(filteredProvinces[index]['iso']),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
