import 'package:balance_history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'injection.dart' as injector;

void main() async {
  injector.init();
  runApp(const MyApp());
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.locator<HistoryBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: double.infinity - 10,
              height: 400,
              child: SfCartesianChart(
                series: <SplineSeries>[
                  // Renders line chart
                  SplineSeries<ChartData, dynamic>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
