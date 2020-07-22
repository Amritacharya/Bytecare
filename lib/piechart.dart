import 'dart:math';

import 'package:flutter/material.dart';

class ChartView extends StatefulWidget {
  ChartView({Key key}) : super(key: key);

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget labelWidget(Category category, int index) {
      return InkWell(
        child: Container(
          height: 30,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  selectedIndex == index ? Colors.orange : Colors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    category.name,
                    style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black),
                  )
                ],
              ),
              Text(
                category.amount.toString() + "USD",
                style: TextStyle(
                    color:
                        selectedIndex == index ? Colors.white : Colors.black),
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.only(top: 70),
          height: 250,
          child: LayoutBuilder(
            builder: (context, constraint) => Container(
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: constraint.maxWidth * 0.5,
                      child: CustomPaint(
                        child: Center(),
                        foregroundPainter: PieChart(
                            width: constraint.maxWidth * 0.5,
                            categories: kCategories,
                            selectedIndex: selectedIndex),
                      ),
                    ),
                  ),
                  Container(
                    height: constraint.maxWidth * 0.3,
                    margin: EdgeInsets.only(top: constraint.maxWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          offset: Offset(-1, -1),
                          color: Colors.white,
                        ),
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            kCategories.length.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          Text("Expenses")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: kCategories.length,
                itemBuilder: (context, index) {
                  return labelWidget(kCategories[index], index);
                }))
      ],
    );
  }
}

class PieChart extends CustomPainter {
  PieChart(
      {@required this.categories, @required this.width, this.selectedIndex});

  final List<Category> categories;
  final double width;
  final selectedIndex;
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width * 0.5, size.height * 0.3);
    double radius = min(size.width / 2, size.height / 2) + 10;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.amount);
    // The angle/radian at 12 o'clcok
    double startRadian = pi / 2;
    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      final _textPainter = TextPainter(textDirection: TextDirection.ltr);

      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.amount / total * 2 * pi;
      print(startRadian.toString());
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = currentCategory.color;
      canvas.drawArc(
        Rect.fromCircle(
            center: center,
            radius: selectedIndex == index ? radius : radius - 10),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      var xAngle = cos(startRadian + sweepRadian / 2);
      var yAngle = sin(startRadian + sweepRadian / 2);
      var featureOffset = Offset(size.width * 0.5 + radius * xAngle,
          size.height * 0.3 + radius * yAngle);

      var labelYOffset = yAngle < 0 ? -24 : 0;
      var labelXOffset = xAngle < 0 ? -24 : 0;
      int percentage = (currentCategory.amount / total * 100).round();
      _textPainter.text = TextSpan(
          text: percentage.toString() + "\%",
          style: TextStyle(color: Colors.white));
      _textPainter.layout(
        minWidth: 0,
        maxWidth: double.maxFinite,
      );
      _textPainter.paint(
          canvas,
          Offset(featureOffset.dx + labelXOffset,
              featureOffset.dy + labelYOffset));

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  Category(this.name, {@required this.amount, this.color});

  final String name;
  final double amount;
  final Color color;
}

final kCategories = [
  Category('Education', amount: 94.00, color: Colors.lightBlue),
  Category('Food', amount: 12.54, color: Colors.green),
  Category('Child', amount: 34.90, color: Colors.yellow),
  Category('Beauty & care', amount: 45.65, color: Colors.redAccent),
];
