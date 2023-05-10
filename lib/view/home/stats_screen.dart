import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
  int touchedIndex2 = 0;
}

class _StatsScreenState extends State<StatsScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _selectedInterval = 0;
  List<String> _intervals = ['Today', 'Week', 'Month'];
  List<String> _cardTitles = [
    'aaaaa',
    'App Usage',
    'Battery Usage',
    'Web Usage'
  ];

  late List<BarChartGroupData> showingBarGroups;
  int _selectedCardIndex = 0;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  // Dummy data for the bar graph
  List<double> _hours = [5, 7, 4, 9, 8, 6, 5];
  List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  late List<BarChartGroupData> rawBarGroups;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                _buildScreenTimeContent(),
                _buildAppUsageContent(),
                _buildBatteryUsageContent(),
                _buildWebUsageContent(),
              ],
            ),
          ),
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildScreenTimeContent() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 200,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Center(child: Text('Card ${index + 1}')),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Screen Time Graph'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1h';
    } else if (value == 10) {
      text = '3h';
    } else if (value == 19) {
      text = '5h';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['12am', '3pm', '8pm', '12pm', '4am', '8am', '10am'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Color(0xFF01fbce),
          width: 5,
        ),
        BarChartRodData(
          toY: y2,
          color: Color(0xFFfc3175),
          width: 5,
        ),
      ],
    );
  }

  Widget _buildAppUsageContent() {
    return Column(
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
                  BarChartRodData(toY: 10, width: 15, color: Colors.amber),
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 9, width: 15, color: Colors.amber),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 4, width: 15, color: Colors.amber),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 2, width: 15, color: Colors.amber),
                ]),
              ],
            ),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
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

  Widget _buildBatteryUsageContent() {
    return Container(
      child: Text('Battery Usage'),
    );
  }

  Widget _buildWebUsageContent() {
    return Container(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  int touchedIndexx = 0;
  return List.generate(4, (i) {
    final isTouched = i == touchedIndexx;
    final fontSize = isTouched ? 20.0 : 16.0;
    final radius = isTouched ? 110.0 : 100.0;
    final widgetSize = isTouched ? 55.0 : 40.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Color(0xff633ebb),
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgePositionPercentageOffset: .98,
        );
      case 1:
        return PieChartSectionData(
          color: Color(0xffbc6cca),
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgePositionPercentageOffset: .98,
        );
      case 2:
        return PieChartSectionData(
          color: Color(0xfff2b360),
          value: 16,
          title: '16%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgePositionPercentageOffset: .98,
        );
      case 3:
        return PieChartSectionData(
          color: Color(0xfff13c59),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgePositionPercentageOffset: .98,
        );
      default:
        throw Exception('Oh no');
    }
  });
}
