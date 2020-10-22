import 'package:covid19/data_source.dart';
import 'package:covid19/localization/localization_methods.dart';
import 'package:covid19/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage() ));

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(getTranslated(context, 'FAQS'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,),),
                  Icon( Icons.arrow_forward,
                    color: Colors.white,),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()
            {
              launch('https://covid19responsefund.org/en/');

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(getTranslated(context, 'DONATE'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,),),
                  Icon( Icons.arrow_forward,
                    color: Colors.white,),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()
            {
              launch('https://www.who.int/indonesia/news/novel-coronavirus/mythbusters');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(getTranslated(context, 'MYTH_BUSTERS'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,),),
                  Icon( Icons.arrow_forward,
                    color: Colors.white,),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
