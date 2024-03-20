import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tokat/pages/google_map.dart';

class MyMapPage extends StatefulWidget {

  const MyMapPage({super.key});

  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  String selectedCountry = "";
  double value = 0;
  final ulkeTextEditing = TextEditingController();
  final List<String> itemList = [
    'Türkiye',
    'Amerika Birleşik Devletleri',
    'Grönland','Rusya'
    'Kanada',
    'United States',
    'Turkestan',
    'TRNC',
    'Canada',
    'Fransa',
    'İngiltere'
  ];
  final Map<String,double> values = {
    'Türkiye':354,    'Amerika Birleşik Devletleri':6345,
'Kanada':5478,
    'Grönland':2341,
    'Rusya':5153,
    'İngiltere':7431,
    'Fransa':7431,
    'United States':6345,
    'Azerbaijan':7624,
    'Turkestan':742,
    'TRNC':63445,
    'Canada':5478

  };
void refresh(){
  selectedCountry=ulkeTextEditing.text;
  value = values[ulkeTextEditing.text]??0;
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
   // print(list);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapPage(ulke: ulkeTextEditing),
                      ));
                },
                child: Image.asset("assets/pic/map.png")),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: Center(
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(controller: ulkeTextEditing,
                        decoration: InputDecoration(labelText: "Ülke adı", hintText: "Türkiye",
                          filled: true,
                          fillColor: Color(0xFF5FBB9F),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Color(0xFF5FBB9F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Color(0xFF5FBB9F),
                            ),
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return itemList
                            .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        ulkeTextEditing.text = suggestion;
                        selectedCountry=ulkeTextEditing.text;
                        value = values[ulkeTextEditing.text]!;
                        setState(() {

                        });
                        print(value);
                        print(ulkeTextEditing.text);
                      },
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  refresh();
                }, icon: Icon(Icons.search))
              ],
            ),

            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: MediaQuery.of(context).size.width * 2 / 3,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Text(selectedCountry==""? "Ülke seçiniz": selectedCountry, style: TextStyle(fontSize: 24),),
                SizedBox(height: 14,),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(79, 157, 133, 100),
                  ),
                  child: Center(
                    child: selectedCountry!=""?Text(
                      '${value} KG CO2',textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ):Text(
                      '-',textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),



                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
