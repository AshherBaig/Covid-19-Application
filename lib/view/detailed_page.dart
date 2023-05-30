import 'package:covid_19/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatefulWidget {
  String image, name;
  int totalCases, totalDeath, totalRecovered, active, critical, test;
  DetailedPage(
      {Key? key,
      required this.image,
      required this.name,
      required this.critical,
      required this.active,
      required this.test,
      required this.totalCases,
      required this.totalDeath,
      required this.totalRecovered})
      : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .097),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        ReusalbeRow(title: "Cases", value: widget.totalCases.toString()),
                        ReusalbeRow(title: "Tests", value: widget.test.toString()),
                        ReusalbeRow(title: "Active", value: widget.active.toString()),
                        ReusalbeRow(title: "Critical", value: widget.critical.toString()),
                        ReusalbeRow(title: "Total Death", value: widget.totalDeath.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
