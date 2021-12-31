import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/data.dart';
import 'package:untitled/helpers/getcolors.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/expense_model.dart';
import 'package:untitled/widgets/bar_charts.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CategoryScreen(category: category)),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(height: 10),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constrain) {
              final double maxbarWidth = constrain.maxWidth;
              final double percent =
                  (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barWidht = percent * maxbarWidth;

              if (barWidht < 0) {
                barWidht = 0;
              }

              return Stack(
                children: [
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100]),
                  ),
                  Container(
                    height: 15,
                    width: barWidht,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: getColors(context, percent),
                    ),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // floating: true,
            pinned: true,
            expandedHeight: 100,
            forceElevated: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
              onPressed: () {},
            ),
            actions: const [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarCharts(weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expanse) {
                    totalAmountSpent += expanse.cost;
                  });
                  return _buildCategory(category, totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
