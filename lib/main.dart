import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/brandPage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabela FIPE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabela FIPE"),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // button carros
            Container(
              padding: EdgeInsets.only(top: 15),
              width: 300.0,
              height: 100.0,
              child: RaisedButton(
                key: Key('btn-carros'),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) => BrandPage(title: 'carros')
                    )
                  );
                },
                color: Colors.blue[300],
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Carros', style: TextStyle(fontSize: 20),),
                    Icon(Icons.directions_car)
                  ], 
                ),
              ),
            ),
            //button motos
            Container(
              padding: EdgeInsets.only(top: 15),
              width: 300.0,
              height: 100.0,
              child: RaisedButton(
                key: Key('btn-motos'),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) => BrandPage(title: 'motos')
                    )
                  );
                },
                color: Colors.blue[300],
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Motos', style: TextStyle(fontSize: 20),),
                    Icon(Icons.motorcycle)
                  ], 
                ),
              ),
            ),
            //button caminhoes
            Container(
              padding: EdgeInsets.only(top: 15),
              width: 300.0,
              height: 100.0,
              child: RaisedButton(
                key: Key('btn-caminhoes'),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) => BrandPage(title: 'caminhoes')
                    )
                  );
                },
                color: Colors.blue[300],
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Caminhões', style: TextStyle(fontSize: 20),),
                    Icon(Icons.local_shipping)
                  ], 
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}