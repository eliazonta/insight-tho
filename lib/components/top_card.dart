import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  const TopCard({
    super.key, 
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black87,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('B A L A N C E',
                  style: TextStyle(color: Colors.orange[400], fontSize: 16)),
              Text(
                '\$$balance',
                style: TextStyle(color: Colors.orange[400], fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: TextStyle(color: Colors.orange[400])),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('\$$income',
                                style: TextStyle(
                                    color: Colors.orange[400],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Expense',
                                style: TextStyle(color: Colors.orange[400])),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('\$$expense',
                                style: TextStyle(
                                    color: Colors.orange[400],
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        
                        
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
