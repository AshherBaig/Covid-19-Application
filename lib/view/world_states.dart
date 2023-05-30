import 'package:covid_19/methods/WorldStatesModel.dart';
import 'package:covid_19/services/state_services.dart';
import 'package:covid_19/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),vsync: this)..repeat();

  final colorList = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

              FutureBuilder(
                  future: stateServices.fetchWorldStateRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot)
              {
                if (!snapshot.hasData)
                  {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.black,
                        size: 50,
                      ));
                  }
                else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Death": double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            chartRadius: MediaQuery.of(context).size.height * 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,

                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03),
                            child: Card(
                              child: Column(

                                children: [
                                  ReusalbeRow(title: "Total", value: snapshot.data!.cases.toString()),
                                  ReusalbeRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                  ReusalbeRow(title: "Active", value: snapshot.data!.active.toString()),
                                  ReusalbeRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                  ReusalbeRow(title: "Today cases", value: snapshot.data!.todayCases.toString()),
                                  ReusalbeRow(title: "Today recovered", value: snapshot.data!.todayRecovered.toString()),
                                  ReusalbeRow(title: "Today death", value: snapshot.data!.todayDeaths.toString()),

                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CountriesList();
                              }));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa268),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text("Track Countries", style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                        ],
                      );
                }
              }
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusalbeRow extends StatelessWidget {
  String title, value;
  ReusalbeRow({Key? key, required this.title, required this. value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
