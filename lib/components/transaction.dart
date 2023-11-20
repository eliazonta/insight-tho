import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // Name 
  final String transactionName;

  // amount 
  final String amount;

  // Income or outcome 
  final String type; 

  // datetime 
  // final DateTime dateTime;

  NewTransaction({
    required this.transactionName,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.black87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration:  const BoxDecoration(
                        shape: BoxShape.circle, 
                        color: Colors.white,
                        ),
                    child:  Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.orange[400],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(transactionName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ],
              ),
              Text(
                '${type == 'expense' ? '-' : '+'}\$$amount',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      type == 'expense' ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
