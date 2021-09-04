import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackcom_2021/screens/settings_screen/settings_screen.dart';
import 'package:hackcom_2021/theme/size_config.dart';

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
              onPressed: () => Get.to(() => SettingsScreen()),
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
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => DebtItemCard(),
      ),
    );
  }

  Widget _addDialog() {
    return Builder(builder: (context) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return Dialog(
        child: Form(
          key: _formKey,
          child: Material(
            color: Color(0xFF0E0E0E),
            child: Card(
              color: Color(0xFF0E0E0E),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: sy * 5, vertical: sx * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'New Loan',
                      style: GoogleFonts.montserrat(
                          color: Color(0xFF00FFE0), fontSize: sText * 7),
                    ),
                    SizedBox(height: sx * 2),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
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
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Interest',
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Installment',
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Payment',
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: sx * 5),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF1D1D1D),
                        ),
                      ),
                      onPressed: () {},
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
      );
    });
  }
}
