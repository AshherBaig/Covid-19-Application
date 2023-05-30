import 'package:covid_19/services/state_services.dart';
import 'package:covid_19/view/detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../methods/WorldStatesModel.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white30),
                                  subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white30),
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white30),
                                )
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]["country"];

                        if (name.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailedPage(
                                                name: snapshot.data![index]
                                                    ["country"],
                                                image: snapshot.data![index]
                                                    ["countryInfo"]["flag"],
                                                active: snapshot.data![index]
                                                    ["active"],
                                                critical: snapshot.data![index]
                                                    ["critical"],
                                                test: snapshot.data![index]
                                                    ["tests"],
                                                totalCases: snapshot
                                                    .data![index]["cases"],
                                                totalDeath: snapshot
                                                    .data![index]["deaths"],
                                                totalRecovered: snapshot
                                                    .data![index]["recovered"],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text("Cases: " +
                                      snapshot.data![index]["cases"]
                                          .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]["flag"])),
                                ),
                              )
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                            searchController.text.toLowerCase().toString())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailedPage(
                                                name: snapshot.data![index]
                                                    ["country"],
                                                image: snapshot.data![index]
                                                    ["countryInfo"]["flag"],
                                                active: snapshot.data![index]
                                                    ["active"],
                                                critical: snapshot.data![index]
                                                    ["critical"],
                                                test: snapshot.data![index]
                                                    ["tests"],
                                                totalCases: snapshot
                                                    .data![index]["cases"],
                                                totalDeath: snapshot
                                                    .data![index]["deaths"],
                                                totalRecovered: snapshot
                                                    .data![index]["recovered"],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]["country"]),
                                  subtitle: Text("Cases: " +
                                      snapshot.data![index]["cases"]
                                          .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]["flag"])),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
