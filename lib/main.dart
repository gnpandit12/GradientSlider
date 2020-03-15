import 'package:flutter/material.dart';
import 'dart:math' as math;


void main() => runApp(MyApp());


double riskProfileSliderValue = 0.0;


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SliderTheme(
          data: SliderThemeData(
              trackShape: RiskProfileSlider(),
            trackHeight: 15
          ),
          child: Slider(
              value: riskProfileSliderValue,
              divisions: 3,
              onChanged: (newValue) {
                setState(() {
                  riskProfileSliderValue = newValue;
                  print('CurrentValue: $newValue');
                });
              }
          ),
        ),
      )
    );
  }
}

class RiskProfileSlider extends SliderTrackShape{

  @override
  Rect getPreferredRect({RenderBox parentBox, Offset offset = Offset.zero, SliderThemeData sliderTheme, bool isEnabled, bool isDiscrete}) {

    final double overlayWidth = sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + overlayWidth / 2;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    // rectangular track should be padded not just by the overlay, but by the
    // max of the thumb and the overlay, in case there is no overlay.
    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset, {RenderBox parentBox, SliderThemeData sliderTheme, Animation<double> enableAnimation, Offset thumbCenter, bool isEnabled, bool isDiscrete, TextDirection textDirection}) {
    final rect = new Rect.fromLTWH(0.0, 0.0, 400, 20);
    final double overlayWidth = sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackWidth = parentBox.size.width - overlayWidth;

    Color greenOne = new Color(0xff2E7D32);
    Color greenTwo = new Color(0xff43A047);
    Color greenThree = new Color(0xff689F38);
    Color greenFour = new Color(0xff4CAF50);

    Color yellowOne = new Color(0xffFFD600);
    Color yellowTwo = new Color(0xffFFFF00);
    Color yellowThree = new Color(0xffFFEE58);

    Color redOne = new Color(0xffFF5722);
    Color redTwo = new Color(0xffc62828);
    Color redThree = new Color(0xffDD2C00);




    final gradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        tileMode: TileMode.clamp,
        colors: [
          greenOne,
          greenTwo,
          greenThree,
          greenFour,

          yellowOne,
          yellowTwo,
          yellowThree,

          redOne,
          redTwo,
          redThree

        ]
    );

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint gradientPaint  =
    new Paint()
      ..shader = gradient.createShader(rect
      );

    context.canvas.drawRRect(
        RRect.fromRectAndRadius(trackRect,
            Radius.circular(20)
        ),
        gradientPaint);
  }



}
