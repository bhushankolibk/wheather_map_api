import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/app_const/common.dart';
import 'package:wheather_app/vm/vm_wheater.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/widget.dart/wheather_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _errorMessage = "Loading...";
  bool _isLoading = false;
  Future<void> _callApi() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<VmWheather>(context, listen: false).getData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
              style: TextStyle(
                  color: Theme.of(context).accentColor.withAlpha(80),
                  fontSize: 14),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _callApi();
              setState(() {});
            },
            color: Colors.black54,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<VmWheather>(builder: (context, vmWheather, ch) {
              if (vmWheather.responseState == requestResponseState.Error) {
                _errorMessage = vmWheather.msg;
              }
              return vmWheather.responseState == requestResponseState.Loading
                  ? Center(
                      child: Text(_errorMessage),
                    )
                  : WeatherWidget(
                      weather: vmWheather.wheatherData,
                    );
            }),
    );
  }
}
