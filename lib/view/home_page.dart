import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/common/app_const.dart';
import 'package:wheather_app/vm/vm_wheater.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _errorMessage = "Loading...";
  void _callApi() async {
    await Provider.of<VmWheather>(context, listen: false).getData();
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
        title: Text("Wheather"),
      ),
      body: Consumer<VmWheather>(builder: (context, vmWheather, ch) {
        return vmWheather.responseState == requestResponseState.Loading
            ? Center(
                child: Text(_errorMessage),
              )
            : Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(vmWheather?.wheatherData?.city?.name ?? ""),
                      Text(vmWheather
                          ?.wheatherData?.list?.first?.weather[0]?.description
                          .toString()),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
