import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackcom_2021/theme/size_config.dart';

class DebtItemCard extends StatelessWidget {
  const DebtItemCard({Key? key}) : super(key: key);

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
                      'High school First-Year Loan',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF00FFE0),
                        fontSize: sText * 4,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              SizedBox(height: sx * 3.2),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: sy * 50,
                  childAspectRatio: 4,
                ),
                children: [
                  Text('Interest: 15%',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('Installment: \$20000',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('Principal: \$200000',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('Payment: \$2000',
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
}
