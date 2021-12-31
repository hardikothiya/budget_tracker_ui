import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/helpers/getcolors.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/expense_model.dart';
import 'package:untitled/widgets/radial_painter.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpanses() {
    List<Widget> expanseList = [];
    widget.category.expenses.forEach((Expense expense) {
      expanseList.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  expense.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${expense.cost.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(
      children: expanseList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountSpent += expense.cost;
    });

    final double amountleft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountleft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0)
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey.shade200,
                    percent: percent,
                    width: 15.0,
                    lineColor: getColors(context, percent)),
                child: Center(
                  child: Text(
                    '\$${amountleft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            _buildExpanses(),
          ],
        ),
      ),
    );
  }
}
