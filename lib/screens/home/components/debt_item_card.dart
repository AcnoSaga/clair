import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackcom_2021/models/debt_item.dart';
import 'package:hackcom_2021/theme/size_config.dart';
import 'package:hackcom_2021/utils/number_shortener.dart';

class DebtItemCard extends StatelessWidget {
  final DebtItem debtItem;
  const DebtItemCard({Key? key, required this.debtItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      )),
      child: Card(
        color: Color(0xFF1D1D1D),
        margin: EdgeInsets.symmetric(horizontal: sy * 5, vertical: sx * 2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sy * 5, vertical: sx * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      debtItem.title,
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF00FFE0),
                        fontSize: sText * 4,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  IconButton(
                      onPressed: () => _deleteDialog(debtItem.id),
                      icon: Icon(Icons.delete, color: Colors.white))
                ],
              ),
              SizedBox(height: sx * 3.2),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: sy * 50,
                  childAspectRatio: 2,
                ),
                children: [
                  Text('Interest: ${debtItem.interestRate}%',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text(
                      'Number of installments: ${numberShortener(debtItem.numberOfInstallments.round())} ',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text(
                      'Principal: \$${numberShortener(debtItem.principal.round())}',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text(
                      'Time Period: ${numberShortener(debtItem.timePeriod.round())} months',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _deleteDialog(String id) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    await Get.dialog(
      Form(
        key: _formKey,
        child: AlertDialog(
          title: Text(
              'Are you sure you want to delete this item?\nThis action can not be reversed.'),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('debtItems')
                    .doc(id)
                    .delete();
                Get.back();
              },
              icon: Icon(
                Icons.check_circle,
                color: Colors.red,
              ),
              label: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton.icon(
              onPressed: Get.back,
              icon: Icon(
                Icons.cancel,
                color: Colors.green,
              ),
              label: Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
