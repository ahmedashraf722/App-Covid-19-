import 'dart:convert';
import 'package:covid19/data_source.dart';
import 'package:covid19/localization/localization_methods.dart';
import 'package:covid19/localization/models.dart';
import 'package:covid19/main.dart';
import 'package:covid19/most_effected_countries.dart';
import 'package:covid19/pages/country_page.dart';
import 'package:covid19/panels/info_panel.dart';
import 'package:covid19/panels/world_wide_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;
  fetchCountriesData() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }

  Map historyData;

  fetchHistoryData() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    http.Response response = await  http.get('https://corona.lmao.ninja/v2/historical/all');

    setState(() {
      historyData = json.decode(response.body);
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
    fetchHistoryData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'COVID-19_Panel')),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: DropdownButton(
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                  value: lang,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[Text(lang.flag,style: TextStyle(fontSize: 20),), Text(lang.name)],
                  )))
                  .toList(),
              onChanged: (Language lang) {
                _changeLanguage(lang);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              //  width: 100,
              height: 100,
              color: Colors.orange.shade100,
              child: Text(
                getLangCode(context) == ARABIC ? DataSource.quoteAr : DataSource.quote,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),


            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(getTranslated(context, 'WorldWide'),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight:FontWeight.bold),),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage() ));

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlack,
                      ),
                      padding: EdgeInsets.all(10),
                      child:Text(getTranslated(context, 'Regional'),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight:FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null ? CircularProgressIndicator() : WorldWidePanel(worldWide: worldData, historyData: historyData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: Text(getTranslated(context, 'Most_Affected_Countries'),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight:FontWeight.bold),),
            ),
            SizedBox(height: 1),
            countriesData == null ? Container() :
            MostAffectedPanel( countryData: countriesData,),
            SizedBox(height: 5,),
            InfoPanel(),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 10,bottom: 10,top: 10,),
              child: Text(getTranslated(context, 'WE_ARE_TOGETHER_IN_THIS_EPIDEMIC'),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: primaryBlack,),),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(Language lang) async{
    Locale _temp = await setLocale(lang.languageCode);
    Home.setLocale(context, _temp);


  }


}

