import 'package:clock_app/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart' show DateFormat;
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late List<_TimeDetails> _worldClockData;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    super.initState();
    final DateTime currentTime = DateTime.now().toUtc();
    _worldClockData = <_TimeDetails>[
      _TimeDetails('Seattle', 47.60621, -122.332071,
          currentTime.subtract(const Duration(hours: 7))),
      _TimeDetails('Belem', -1.455833, -48.503887,
          currentTime.subtract(const Duration(hours: 3))),
      _TimeDetails('Greenland', 71.706936, -42.604303,
          currentTime.subtract(const Duration(hours: 2))),
      _TimeDetails('Yakutsk', 62.035452, 129.675475,
          currentTime.add(const Duration(hours: 9))),
      _TimeDetails('Delhi', 28.704059, 77.10249,
          currentTime.add(const Duration(hours: 5, minutes: 30))),
      _TimeDetails('Brisbane', -27.469771, 153.025124,
          currentTime.add(const Duration(hours: 10))),
      _TimeDetails('Harare', -17.825166, 31.03351,
          currentTime.add(const Duration(hours: 2))),
    ];
    _mapSource = const MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
    );
  }

  @override
  void dispose() {
    _worldClockData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text(
            "Clock",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            height: 250,
            child: _buildMapsWidget(),
          ),
          SizedBox(height: 10),
          Text(
            DateFormat("hh:mm aa").format(DateTime.now()),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat("EEE, dd MMMM").format(DateTime.now()),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildMapsWidget() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SfMapsTheme(
        data: const SfMapsThemeData(
          shapeHoverColor: Colors.transparent,
          shapeHoverStrokeColor: Colors.transparent,
          shapeHoverStrokeWidth: 0,
        ),
        child: SfMaps(
          layers: <MapLayer>[
            MapShapeLayer(
              loadingBuilder: (BuildContext context) {
                return const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
              source: _mapSource,
              initialMarkersCount: 7,
              markerBuilder: (_, int index) {
                return MapMarker(
                  longitude: _worldClockData[index].longitude,
                  latitude: _worldClockData[index].latitude,
                  alignment: Alignment.topCenter,
                  offset: const Offset(0, -4),
                  size: const Size(200, 200),
                  child: _ClockWidget(
                      countryName: _worldClockData[index].countryName,
                      date: _worldClockData[index].date),
                );
              },
              strokeWidth: 0,
              // color:
              // model.themeData.colorScheme.brightness == Brightness.light
              //     ? const Color.fromRGBO(71, 70, 75, 0.2)
              //     : const Color.fromRGBO(71, 70, 75, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClockWidget extends StatefulWidget {
  const _ClockWidget({required this.countryName, required this.date});

  final String countryName;
  final DateTime date;

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<_ClockWidget> {
  late String _currentTime;
  late DateTime _date;
  Timer? _timer;

  @override
  void initState() {
    _date = widget.date;
    _currentTime = _getFormattedDateTime(widget.date);
    _timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _updateTime(_date));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorPalette.primary),
          ),
        ),
        Text(
          widget.countryName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Center(
          child: Text(_currentTime,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  void _updateTime(DateTime currentDate) {
    _date = currentDate.add(const Duration(seconds: 1));
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(_date);
    });
  }

  String _getFormattedDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }
}

class _TimeDetails {
  _TimeDetails(this.countryName, this.latitude, this.longitude, this.date);

  final String countryName;
  final double latitude;
  final double longitude;
  final DateTime date;
}
