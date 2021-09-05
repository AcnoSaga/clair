import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackcom_2021/gap.dart';
import 'package:hackcom_2021/models/debt_item.dart';
import 'package:hackcom_2021/screens/report_screen/report_screen.dart';
import 'package:hackcom_2021/screens/settings_screen/settings_screen.dart';
import 'package:hackcom_2021/screens/upi_screen/upi_screen.dart';
import 'package:hackcom_2021/theme/size_config.dart';
import 'package:hackcom_2021/utils/validators/text_validators.dart';

import 'components/debt_item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        title: Text(
          'clair',
          style: GoogleFonts.montserrat(
              color: Color(0xFF00FFE0), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => ReportScreen()),
              icon: Icon(Icons.library_books)),
          IconButton(
              onPressed: () => Get.to(() => SettingsScreen()),
              icon: Icon(Icons.settings)),
        ],
        backgroundColor: Color(0xFF1D1D1D),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: Color(0xFF00FFE0),
        onPressed: () {
          Get.dialog(
            _addDialog(),
            barrierColor: Colors.black.withOpacity(0.6),
          );
        },
        child: Icon(Icons.add, color: Color(0xFF1D1D1D)),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('debtItems')
            .where(
              'userId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )
            .orderBy('createdAt')
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
                  'Seems like there are no existing items.\n\nTry creating one with the Add button below.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () => Get.to(() => UpiScreen(
                        onSuccess: () async {
                          if (!(doc["installment"] < 1)) {
                            if (doc["installment"] == 1) {
                              return await FirebaseFirestore.instance
                                  .collection('debtItems')
                                  .doc(doc.id)
                                  .delete();
                            }
                            await FirebaseFirestore.instance
                                .collection('debtItems')
                                .doc(doc.id)
                                .update({
                              "installment": FieldValue.increment(-1),
                            });
                          }
                        },
                      )),
                  child: DebtItemCard(
                    debtItem: DebtItem.fromMap(doc.data(), doc.id),
                  ),
                );
              },
            );
          }
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

  Widget _addDialog() {
    final nameController = TextEditingController();
    final interestController = TextEditingController();
    final installmentController = TextEditingController();
    final principalController = TextEditingController();
    final intervalController = TextEditingController();
    return Builder(builder: (context) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return Dialog(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Material(
              color: Color(0xFF0E0E0E),
              child: Card(
                color: Color(0xFF0E0E0E),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sy * 5, vertical: sx * 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'New Loan',
                        style: GoogleFonts.montserrat(
                            color: Color(0xFF00FFE0), fontSize: sText * 7),
                      ),
                      Gap(height: 2),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: nameController,
                        validator: TextValidators.loanName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Gap(height: 2),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: TextValidators.number,
                        keyboardType: TextInputType.number,
                        controller: interestController,
                        decoration: InputDecoration(
                          labelText: 'Interest rate per installment',
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Gap(height: 2),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: installmentController,
                        validator: TextValidators.number,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number of installments',
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Gap(height: 2),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: principalController,
                        validator: TextValidators.number,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Principal to be paid (without interest)',
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Gap(height: 2),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: intervalController,
                        validator: TextValidators.integer,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Installment time period (in months)',
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Gap(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF1D1D1D),
                          ),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          Get.back();
                          await FirebaseFirestore.instance
                              .collection('debtItems')
                              .add({
                            "userId": FirebaseAuth.instance.currentUser!.uid,
                            "name": nameController.text,
                            "interest": double.parse(interestController.text),
                            "installment":
                                double.parse(installmentController.text),
                            "principal": double.parse(principalController.text),
                            "interval": int.parse(intervalController.text),
                            "createdAt": Timestamp.now()
                          });
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.montserrat(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
