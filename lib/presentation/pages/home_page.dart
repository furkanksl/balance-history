import 'package:balance_history/data/services/utility_service.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_event.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_state.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final UtilityService _utilityService = UtilityService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Your Balance',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Enter a user address',
                    ),
                    onSubmitted: (query) {},
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () => context.read<HistoryBloc>().add(
                          OnAddressChanged(_controller.text),
                        ),
                    child: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if (state is BalanceHistoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BalanceHistoryHasData) {
                  // print(state.result);
                  return SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                      ),
                      series: <SplineSeries>[
                        // Renders line chart
                        SplineSeries<History, dynamic>(
                          dataSource: _utilityService.getOrderedBalanceHistory(
                            type: ORDER_TYPE.daily,
                            list: state.result,
                          ),
                          xValueMapper: (History data, _) => data.dateTime!.day,
                          yValueMapper: (History data, _) =>
                              _utilityService.satoshisToUSD(
                            data.balance,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is BalanceHistoryError) {
                  return const Text('There is no user balance history');
                } else {
                  return const Text('');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
