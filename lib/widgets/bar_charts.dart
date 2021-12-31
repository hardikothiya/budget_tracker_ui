import 'package:flutter/material.dart';

class BarCharts extends StatelessWidget {
  BarCharts(this.expenses);
  final List<double> expenses;

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Weekly Spending',
            style: TextStyle(
                letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: null, icon: Icon(Icons.arrow_back, size: 30)),
              Text(
                '2 Dec 21 - 2 Jan 22',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.arrow_forward, size: 30),
              ),
              SizedBox(height: 30),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: 'su',
                  amountSpent: expenses[1],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Mu',
                  amountSpent: expenses[2],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Tu',
                  amountSpent: expenses[3],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'We',
                  amountSpent: expenses[4],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Th',
                  amountSpent: expenses[5],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Fr',
                  amountSpent: expenses[6],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Sa',
                  amountSpent: expenses[0],
                  mostExpensive: mostExpensive),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  Bar(
      {required this.label,
      required this.amountSpent,
      required this.mostExpensive});

  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 6),
        Container(
          height: barHeight,
          width: 15,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }
}
