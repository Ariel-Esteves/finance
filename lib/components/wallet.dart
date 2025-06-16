import 'package:finance/models/wallet_model_dto.dart';
import 'package:finance/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Wallet extends StatefulWidget {
  Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController balanceController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    balanceController.text = '0.00';
    incomeController.text = '0.00';
    expenseController.text = '0.00'
    _loadWalletData();
  }

  void _loadWalletData() async {
    print('Loading wallet data...');
    final walletRepository = WalletRepository();

    final response = await walletRepository.get();

    setState(() {
      balanceController.text = response.balance.toStringAsFixed(2);
      incomeController.text = response.income.toStringAsFixed(2);
      expenseController.text = response.outcome.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 224,
      width: double.infinity,
      child: Row(
        children: [
          // First element in the row
          Container(
            width: screenWidth * 0.5,
            margin: EdgeInsets.all(16),
            child: Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "R\$ ${balanceController.text}",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Second element in the row
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // First element in the column
                Expanded(
                  flex: 1,
                  child: Container(
                    width: screenWidth * 0.5,
                    margin: const EdgeInsets.only(
                      top: 16,
                      bottom: 8,
                      left: 0,
                      right: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Entradas",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "R\$ ${incomeController.text}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Second element in the column
                Expanded(
                  flex: 1,
                  child: Container(
                    width: screenWidth * 0.5,
                    margin: const EdgeInsets.only(
                      top: 8,
                      bottom: 16,
                      left: 0,
                      right: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Saídas",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "R\$ ${expenseController.text}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
