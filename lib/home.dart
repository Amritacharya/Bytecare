import 'package:bytecare/piechart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';

class ExpensePage extends StatefulWidget {
  ExpensePage({Key key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  String date;
  bool listItem = true;
  bool chartItem = false;
  bool moreStatus = false;

  List<Widget> categories = [];
  List<Widget> incomingExpenses = [];
  @override
  void initState() {
    setState(() {
      date = DateFormat.yMMMMd().format(DateTime.now());
      categories.add(categoryItem(
          Icon(
            Icons.school,
            color: Colors.yellow,
          ),
          "Education"));
      categories.add(categoryItem(
          Icon(
            Icons.fastfood,
            color: Colors.lightBlue,
          ),
          "Nutrition"));
      categories.add(categoryItem(
          Icon(
            Icons.child_friendly,
            color: Colors.green,
          ),
          "Child"));
      categories.add(categoryItem(
          Icon(
            Icons.spa,
            color: Colors.redAccent,
          ),
          "Beauty & Care"));
      categories.add(categoryItem(
          Icon(
            Icons.school,
            color: Colors.yellow,
          ),
          "Education"));
      categories.add(categoryItem(
          Icon(
            Icons.fastfood,
            color: Colors.lightBlue,
          ),
          "Nutrition"));
      categories.add(categoryItem(
          Icon(
            Icons.child_friendly,
            color: Colors.green,
          ),
          "Child"));
      categories.add(categoryItem(
          Icon(
            Icons.spa,
            color: Colors.redAccent,
          ),
          "Beauty & Care"));
      incomingExpenses.add(expensesCard(
          Icon(
            Icons.spa,
            color: Colors.redAccent,
          ),
          "Beauty & Care"));
      incomingExpenses.add(expensesCard(
          Icon(
            Icons.spa,
            color: Colors.redAccent,
          ),
          "Beauty & Care"));
      incomingExpenses.add(expensesCard(
          Icon(
            Icons.spa,
            color: Colors.redAccent,
          ),
          "Beauty & Care"));
    });
    super.initState();
  }

  Widget categoryItem(Icon icon, String title) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              icon,
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Color(0xff203152),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    fontSize: 12),
              )
            ],
          ),
        ));
  }

  Widget expensesCard(Icon icon, String title) {
    return IntrinsicWidth(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: icon,
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: Color(0xff203152),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    fontSize: 12),
              ),
            ),
            ListTile(
              title: Text(
                "Dermal Softening",
                style: TextStyle(
                    color: Color(0xff203152),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    fontSize: 16),
              ),
              isThreeLine: true,
              subtitle: Text(
                  "Treatment generally takes 20 to 30 minutes and, using a micro needle, the dermal filler is injected to instantly restore volume, softening lines and wrinkles."),
            ),
            ListTile(
              title: Text(
                "LOCATION",
                style: TextStyle(
                    color: Color(0xff203152),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    fontSize: 12),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.location_on), Text("Kathmandu,Nepal")],
              ),
            ),
            Expanded(
                child: InkWell(
                    onTap: () {},
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "CONFIRM 12.54 USD",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ))))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget listWidget() {
      return Column(
        children: [
          Container(
            child: GridView.count(
              childAspectRatio: 4,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: moreStatus ? categories : categories.sublist(0, 4),
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () => setState(() {
                moreStatus = !moreStatus;
              }),
              child: !moreStatus
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("MORE",
                            style: TextStyle(
                                color: Color(0xff203152),
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                                fontSize: 10)),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("LESS",
                            style: TextStyle(
                                color: Color(0xff203152),
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                                fontSize: 10)),
                        Icon(Icons.keyboard_arrow_up),
                      ],
                    ),
            ),
          ),
          ListTile(
            title: Text(
              "INCOMING EXPENSES",
              style: TextStyle(
                  color: Color(0xff203152),
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Montserrat',
                  fontSize: 15),
            ),
            subtitle: Text(
              "12 Total",
              style: TextStyle(fontSize: 12),
            ),
            enabled: false,
          ),
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width * 0.9,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
              ),
              items: incomingExpenses,
            ),
          )
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff203152),
          ),
          backgroundColor: Colors.white,
          leading: Icon(Icons.arrow_back),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.more_horiz, color: Color(0xff203152)),
            )
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(color: Colors.white),
                  // padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "My Expenses",
                          style: TextStyle(
                              color: Color(0xff203152),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Montserrat',
                              fontSize: 20),
                        ),
                        subtitle: Text("Summary (Private)"),
                        enabled: false,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.today,
                            color: Color(0xff203152),
                          ),
                          backgroundColor: Colors.grey[100],
                        ),
                        title: Text(
                          date,
                          style: TextStyle(
                              color: Color(0xff203152),
                              fontWeight: FontWeight.w900,
                              height: 0.6,
                              fontFamily: 'Montserrat',
                              fontSize: 16),
                        ),
                        subtitle: Text("18% more than last month"),
                        enabled: false,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "CATEGORIES",
                          style: TextStyle(
                              color: Color(0xff203152),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Montserrat',
                              fontSize: 15),
                        ),
                        subtitle: Text(
                          "7 Total",
                          style: TextStyle(fontSize: 12),
                        ),
                        enabled: false,
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            InkWell(
                              onTap: () => setState(() {
                                listItem = true;
                                chartItem = false;
                              }),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.assessment,
                                  color: listItem
                                      ? Colors.white
                                      : Color(0xff203152),
                                ),
                                backgroundColor: listItem
                                    ? Colors.orange
                                    : Colors.transparent,
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                listItem = false;
                                chartItem = true;
                              }),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.list,
                                  color: chartItem
                                      ? Colors.white
                                      : Color(0xff203152),
                                ),
                                backgroundColor: chartItem
                                    ? Colors.orange
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(child: listItem ? listWidget() : ChartView()),
                    ],
                  ))
            ],
          ),
        ));
  }
}
