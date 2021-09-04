import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackcom_2021/models/debt_item.dart';
import 'package:hackcom_2021/theme/size_config.dart';
import 'package:hackcom_2021/utils/number_shortener.dart';

import '../../gap.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
          backgroundColor: Color(0xFF1D1D1D),
          title: Text(
            "Report",
            style: GoogleFonts.montserrat(
                color: Color(0xFF00FFE0), fontWeight: FontWeight.bold),
          )),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('debtItems')
            .where(
              'userId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'An unexpected problem occured.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  'Seems like there are no existing items.\n\nTry creating one at the home screen.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }
            final sum = snapshot.data!.docs
                .map((doc) => DebtItem.fromMap(doc.data(), doc.id))
                .fold<double>(0, (previousValue, debtItem) {
              final amount = (debtItem.principal *
                  pow(1 + ((debtItem.interestRate / 100) / debtItem.timePeriod),
                      debtItem.numberOfInstallments / debtItem.timePeriod));
              final weeklyAmount = amount /
                  (debtItem.numberOfInstallments * debtItem.timePeriod * 4);
              return previousValue + weeklyAmount;
            });
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You need',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Gap(height: 2),
                  Text(
                    '\$' + numberShortener(sum.floor()),
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: sText * 25),
                    textAlign: TextAlign.center,
                  ),
                  Gap(height: 2),
                  Text(
                    'per week to manage your loans.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          print(00000000000000000000000000);
          print(snapshot.hasData);
          print(00000000000000000000000000);
          return Center(
            child: Text(
              'Seems like there are no existing items.\n\nTry creating one with the Add button below.',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
