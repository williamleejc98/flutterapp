import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../common/config.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/app_model.dart';
import '../../../../../models/entities/sale_stats.dart';

class SaleStatsChart extends StatelessWidget {
  final SaleStats? saleStats;

  const SaleStatsChart({Key? key, this.saleStats}) : super(key: key);

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 2,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blue,
          width: 7,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(1.0),
            topLeft: Radius.circular(1.0),
          ),
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.red,
          width: 7,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(1.0),
            topLeft: Radius.circular(1.0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var barChartGroupDataList = <BarChartGroupData>[];
    if (saleStats != null) {
      barChartGroupDataList.add(makeGroupData(
          1,
          saleStats!.grossSales?.week1 ?? 0.0,
          saleStats!.earnings?.week1 ?? 0.0));
      barChartGroupDataList.add(makeGroupData(
          2,
          saleStats!.grossSales?.week2 ?? 0.0,
          saleStats!.earnings?.week2 ?? 0.0));
      barChartGroupDataList.add(makeGroupData(
          3,
          saleStats!.grossSales?.week3 ?? 0.0,
          saleStats!.earnings?.week3 ?? 0.0));
      barChartGroupDataList.add(makeGroupData(
          4,
          saleStats!.grossSales?.week4 ?? 0.0,
          saleStats!.earnings?.week4 ?? 0.0));
      barChartGroupDataList.add(makeGroupData(
          5,
          saleStats!.grossSales?.week5 ?? 0.0,
          saleStats!.earnings?.week5 ?? 0.0));
    }

    return Container(
      height: 260,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Colors.grey)),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) =>
                    bottomTitles(value, meta, context),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 40,
                getTitlesWidget: (double value, TitleMeta meta) =>
                    leftTitles(context, value, meta),
              ),
            ),
          ),
          barTouchData: BarTouchData(enabled: false),
          borderData: FlBorderData(
              border: const Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          )),
          barGroups: barChartGroupDataList,
          gridData: const FlGridData(
              drawHorizontalLine: true, drawVerticalLine: false),
          alignment: BarChartAlignment.spaceAround,
        ),
      ),
    );
  }

  Widget leftTitles(BuildContext context, double value, TitleMeta meta) {
    final model = Provider.of<AppModel>(context, listen: false);

    var defaultCurrency = kAdvanceConfig.defaultCurrency;
    var formatCurrency = NumberFormat.compactSimpleCurrency(
        name: defaultCurrency?.symbol ?? '\$',
        decimalDigits: 0,
        locale: model.langCode);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        formatCurrency.format(value),
        style: const TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta, BuildContext context) {
    final Widget text = Text(
      S.of(context).week(value.toInt()),
      style: TextStyle(
        fontSize: 11,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 7, //margin top
      child: text,
    );
  }
}
