import 'package:covid19/data_source.dart';
import 'package:covid19/localization/localization_methods.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'FAQS')),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: ( context, index )
          {
            return ExpansionTile(
              title: Text( getLangCode(context) == ARABIC ? DataSource.questionAnswersAr[index]['question']:DataSource.questionAnswers[index]['question'],
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text( getLangCode(context) == ARABIC ? DataSource.questionAnswersAr[index]['answer']:DataSource.questionAnswers[index]['answer'],
                    style: TextStyle(color: primaryBlack,fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ],

            );

          }),

    );
  }
}
