import 'package:finance/cfg/security.dart';
import 'package:finance/components/wallet.dart';
import 'package:finance/repository/sale_repository.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});
  final TokenStorage token = TokenStorage();
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loggedIn = false;
  // Simulating a logged-in user
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getStatistics();
  }

  Map<String, double> statisticsData = {};
  Future<void> getStatistics() async {
    print('Fetching statistics data...');
    final response = await SaleRepository().getStatistics();
    setState(() {
      statisticsData = {};
      response.forEach((e) {
        statisticsData[e['name']] = e['value'].toDouble();
      });
      print('Statistics data fetched: $statisticsData');
    });
  }

  Future<void> checkLoginStatus() async {
    final tokenStatus = await widget.token.isTokenValid();
    print('token valid? $tokenStatus');
    setState(() {
      loggedIn = tokenStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          toolbarHeight: 100,
          title: const Text(
            "Welcome Ariel",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle, size: 80), // Account login icon
              onPressed: () {
                // Handle account login action here
                print("Account icon pressed");
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16.0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: const Text(
                  'Menu',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    loggedIn ? '/signup' : '/login',
                  ); // Navigate to the Home screen
                },
                title: Text(loggedIn ? 'Loggout' : 'Login'),
              ),
              ListTile(
                leading: Icon(Icons.business),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/interprise',
                  ); // Navigate to the Home screen
                },
                title: Text('Interprise'),
              ),
              ListTile(
                leading: Icon(Icons.home_filled),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/home',
                  ); // Navigate to the Home screen
                },
                title: Text('home'),
              ),

              ListTile(
                leading: Icon(Icons.attach_money),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/sale_view',
                  ); // Navigate to the Home screen
                },
                title: Text('Sale'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/person',
                  ); // Navigate to the Home screen
                },
                title: Text('person'),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product',
                  ); // Navigate to the Home screen
                },
                title: Text('product'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0.0,
                right: 0.0,
                top: 16.0,
                bottom: 16.0,
              ),
              child: Column(children: <Widget>[Wallet()]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 16.0,
              ),
              child:
                  statisticsData.isNotEmpty
                      ? PieChart(dataMap: statisticsData)
                      : const Center(child: Text('No statistics data')),
            ),
          ],
        ),
      ),
    );
  }
}

class profilepic extends StatelessWidget {
  const profilepic({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black.withOpacity(0.2),
              //   spreadRadius: 2,
              //   blurRadius: 5,
              //   offset: Offset(0, 3), // changes position of shadow
              // ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Ariel Welcome to your wallet!",
              style: TextStyle(
                fontSize: 22,
                color: const Color.fromARGB(255, 172, 172, 172),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
