//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_food/models/api_result.dart';
import 'package:flutter_food/models/food_item.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_food/services/api.dart';

const apiBaseUrl = 'https://cpsu-test-api.herokuapp.com';
const apiGetFood = '$apiBaseUrl/foods';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<FoodItem>? _foodList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FOOD LIST')),
      body: Column(
        children: [
          /*Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _fetchFoodData,
              child: const Text('GET FOOD DATA'),
            ),
          ),*/
          Expanded(
            child: Stack(
              children: [
                if (_foodList != null)
                  ListView.builder(
                    itemBuilder: _buildListItem,
                    itemCount: _foodList!.length,
                  ),
                if (_isLoading) Center(child: CircularProgressIndicator()),
                if (_errMessage != null && !_isLoading)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(_errMessage!),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _fetchFoodData();
                          },
                          child: const Text('RETRY'),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

/* แบบยาว
  void _handleClickButton() async {
    setState(() {
      _isLoading = true;
    });
    //type Future<http.Response> of response
    var response = await http.get(Uri.parse(apiGetFood));
    /*response.then((data){ //แทนการใช้ await and async
      print(response.statusCode);
      print(data.body);
    });
     */
    var output = jsonDecode(response.body);
    //print(output['status']);
    //print(output['message']);
    //print(output['data']);
    setState(() {
       _foodList = [];

      output['data'].forEach((item) {
        //print(item['name'] + ' ราคา ' + item['price'].toString());
        var foodItem = FoodItem.fromJson(
            item //ส่ง item ไปเปรียบเหมือนทั้งก้อนข้างล่าง
            /* แบบไม่ใช้ factory fromJson
          id: item['id'],
          name: item['name'],
          price: item['price'],
          image: item['image'],
           */
            );
        _foodList!.add(foodItem);
      });
      _isLoading = false;
    });
  }*/
  /*
  //แบบสั้น
  void _fetchFoodData() async {
    setState(() {
      _isLoading = true;
    });
    //type Future<http.Response> of response
    var response = await http.get(Uri.parse(apiGetFood));

    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      var apiResult = ApiResult.fromJson(output);
      if (apiResult.status == 'ok') {
        setState(() {
          _foodList = output['data'].map<FoodItem>((item) {
            return FoodItem.fromJson(item);
          }).toList();
          _isLoading = false;
        });
      } else {
        //handle error
        setState(() {
          _isLoading = false;
          _errMessage = apiResult.message;
        });
      }
    } else {
      //handle error
      setState(() {
        _isLoading = false;
        _errMessage = 'Network connection failed';
      });
    }
  }
   */
  void _fetchFoodData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('foods');
      setState(() {
        _foodList = data
            .map<FoodItem>((item) => FoodItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = _foodList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              foodItem.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(foodItem.name),
          ],
        ),
      ),
    );
  }
}
