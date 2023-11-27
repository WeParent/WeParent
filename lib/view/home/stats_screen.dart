import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(3.0),
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Color(0xffff2c55)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 17.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "Screen time",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 27.0),
                                Center(
                                  child: Text(
                                    "06h : 00m",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Text(
                                    "in 24h",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xffF1E9FF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.15),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.access_time,
                                  size: 24,
                                ),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Color(0xff43388F)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 17.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "Child",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 26.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.0),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "Build id : efdd0b5e69b0",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "Name : Samsung A21",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.15),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.child_care,
                                  size: 24,
                                ),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Color(0xffBC539F)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 17.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "App usage",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 33.0),
                                Center(
                                  child: Text(
                                    "03h : 30m",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Text(
                                    "in 24h",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xffF1E9FF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.15),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.android,
                                  size: 24,
                                ),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Color(0xffF99417)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 17.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    "Battery level",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 33.0),
                                Center(
                                  child: Text(
                                    "26 %",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.15),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.battery_0_bar,
                                  size: 24,
                                ),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'App Usage',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff144c3f),
                            ),
                          ),
                          SizedBox(height: 13),
                          const Text(
                            '05h:00m',
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3b9f87),
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 200,
                            child: BarChart(
                              BarChartData(
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: FlGridData(
                                  show: false,
                                ),
                                groupsSpace: 10,
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: getTitles2,
                                      reservedSize: 38,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                // add bars
                                barGroups: [
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                        toY: 10,
                                        width: 15,
                                        color: Colors.amber),
                                  ]),
                                  BarChartGroupData(x: 1, barRods: [
                                    BarChartRodData(
                                        toY: 9, width: 15, color: Colors.amber),
                                  ]),
                                  BarChartGroupData(x: 2, barRods: [
                                    BarChartRodData(
                                        toY: 4, width: 15, color: Colors.amber),
                                  ]),
                                  BarChartGroupData(x: 3, barRods: [
                                    BarChartRodData(
                                        toY: 2, width: 15, color: Colors.amber),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Color(0xff4ee4c1),
                elevation: 3.0,
                margin: new EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    const Text(
                      'App Usage',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 253, 253, 253),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '05h:00m',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 150,
                      child: BarChart(
                        BarChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          gridData: FlGridData(
                            show: false,
                          ),
                          groupsSpace: 10,
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: getTitles2,
                                reservedSize: 38,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          // add bars
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(
                                  toY: 10, width: 15, color: Colors.amber),
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                  toY: 9, width: 15, color: Colors.amber),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                  toY: 4, width: 15, color: Colors.amber),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                  toY: 2, width: 15, color: Colors.amber),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget getTitles2(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Facebook', style: style);
        break;
      case 1:
        text = const Text('Tiktok', style: style);
        break;
      case 2:
        text = const Text('Instagram', style: style);
        break;
      case 3:
        text = const Text('Messenger', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
