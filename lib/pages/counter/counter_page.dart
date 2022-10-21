import 'package:flutter/material.dart';
import 'package:flutter_food/pages/counter/counter.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => Counter(),
        child: Column(
          children: const [
            Expanded(
              child: TopPanel(),
            ),
            Expanded(
              child: BottomPanel(),
            ),
          ],
        ),
      ),
    );
  }
}

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Container(
          color: Colors.pink.withOpacity(0.3),
          child: Center(
            child: Text(
              counter.value.toString(),
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        );
      },
    );
  }
}

class BottomPanel extends StatefulWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.3),
      child: Center(
          child: ElevatedButton(
            onPressed: () {
              Provider.of<Counter>(context, listen: false).incrementValue();
            },
            child: const Text('COUNT UP'),
          )),
    );
  }
}