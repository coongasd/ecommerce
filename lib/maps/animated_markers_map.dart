import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_marker.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibmhhdDEyMyIsImEiOiJjbDI0bTVzb3IwNGVpM2RydjR3aHl3eXV4In0.pIr4pF0GjPwekCCua1r8gQ';

const MAPBOX_STYLE = 'mapbox/dark-v10';
const MARKER_COLOR = Color(0XFF3DC5A7);
const MARKER_SIZE_EXPANDED = 55.0;
const MARKER_SIZE_SHRINKED = 38.0;

final _myLocation = LatLng(21.030653, 105.847130);

class AnimatedMarkersMap extends StatefulWidget {
  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;
  bool click = true;

  var points1 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.016708, 105.824490),
  ];
  var points2 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.025614, 105.792168),
  ];
  var points3 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.016708, 105.824490),
  ];
  var points4 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.007827, 105.849024),
  ];
  var points5 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.033591, 105.850977),
  ];
  var points6 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(20.974005, 105.780133),
  ];
  var points7 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.00069, 105.820903),
  ];
  var points8 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.018641, 105.826419),
  ];
  var points9 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.032341, 105.83144),
  ];
  var points0 = <LatLng>[
    LatLng(21.030653, 105.847130),
    LatLng(21.033302, 105.845602),
  ];

  get points => null;
  List<Marker> _buildMarkers() {
    final _makerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];

      _makerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(() {
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut);
                  print('Cừa hàng: ${mapItem.title}');
                  print('${mapItem.timming}');
                  print('${mapItem.warning}');
                });
              },
              child: _LocationMarker(
                selected: _selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return _makerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        title: Text('MapBox'),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.filter_alt_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 16,
              zoom: 13,
              center: _myLocation,
            ),
            nonRotatedLayers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/nhat123/cl2ftvpbq001x15nvf5vgzwd2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmhhdDEyMyIsImEiOiJjbDI0bTVzb3IwNGVpM2RydjR3aHl3eXV4In0.pIr4pF0GjPwekCCua1r8gQ',
                additionalOptions: {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points1, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points2, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points3, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points4, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points5, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points6, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points7, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points8, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points9, strokeWidth: 0.5, color: Colors.lightBlue)
              ]),
              new PolylineLayerOptions(polylines: [
                new Polyline(
                    points: points0,
                    strokeWidth: 0.5,
                    color: (click == false) ? Colors.red : Colors.lightBlue)
              ]),
              MarkerLayerOptions(
                markers: _markers,
              ),
              MarkerLayerOptions(markers: [
                Marker(
                    height: 60,
                    width: 60,
                    point: _myLocation,
                    builder: (_) {
                      return _MyLocationMarker(_animationController);
                    }),
              ]),
            ],
          ),

          //them pageview
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetailds(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset('assets/animated_marker_map/marker.png'),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    final size = 50.0;
    return Center(
        child: Stack(children: [
      Center(
        child: Container(
          height: size * newValue,
          width: size * newValue,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MARKER_COLOR.withOpacity(0.5),
          ),
        ),
      ),
      Center(
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: MARKER_COLOR,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ]));
  }
}

class _MapItemDetailds extends StatelessWidget {
  const _MapItemDetailds({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(mapMarker.image),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        mapMarker.title,
                        style: _styleTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        mapMarker.address,
                        style: _styleAddress,
                      ),
                    ],
                  ))
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              color: MARKER_COLOR,
              elevation: 6,
              child: Text(
                'Gọi hỗ trợ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
