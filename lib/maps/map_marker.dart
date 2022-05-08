import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapMarker {
  const MapMarker(
      {required this.image,
      required this.title,
      required this.address,
      required this.location,
      required this.warning,
      required this.timming});

  final String image;
  final String title;
  final String address;
  final LatLng location;
  final String timming;
  final String warning;
}

final _locations = [
  LatLng(21.016708, 105.824490),
  LatLng(21.025614, 105.792168),
  LatLng(21.007827, 105.849024),
  LatLng(21.033591, 105.850977),
  LatLng(21.036796, 105.813362),
  LatLng(20.974005, 105.780133),
  LatLng(21.00069, 105.820903),
  LatLng(21.018641, 105.826419),
  LatLng(21.032341, 105.83144),
  LatLng(21.033302, 105.845602),
];

const _path = 'assets/animated_marker_map/';

final mapMarkers = [
  MapMarker(
      image: '${_path}lenovo.png',
      title: 'Lenovo',
      address:
          'Địa chỉ : Phòng 709A, Tầng 7, Oriental Tower, 324 Tây Sơn, Ngã Tư Sở, Quận Đống Đa, Hà Nội',
      timming: 'Thời gian dự kiến : 2h25p',
      warning: '',
      location: _locations[0]),
  MapMarker(
      image: '${_path}iphone.png',
      title: 'Iphone',
      address:
          'Địa chỉ :  Phòng 901, Ngôi Nhà Đức Tại TP. Hồ Chí Minh, số 33, đường Lê, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
      timming: 'Thời gian dự kiến : 3h30p',
      warning: '',
      location: _locations[1]),
  MapMarker(
      image: '${_path}xiaomi.png',
      title: 'Xiaomi',
      address: 'Địa chỉ : 31 Nguyễn Tất Thành, Phường 13, Hà Nội',
      timming: 'Thời gian dự kiến : 3h',
      warning: '',
      location: _locations[2]),
  MapMarker(
      image: '${_path}oppo.png',
      title: 'Oppo',
      address: 'Địa chỉ : 27 Nguyễn Trung Trực, Phường Bến Thành, Hà Nội',
      timming: 'Thời gian dự kiến : 35p',
      warning: '',
      location: _locations[3]),
  MapMarker(
      image: '${_path}samsung.png',
      title: 'Samsung',
      address: 'Địa chỉ : Số 2, đường Hải Triều, Phường Bến Nghé, Hà Nội',
      timming: 'Thời gian dự kiến : ...',
      warning: 'Không thể xác định !!',
      location: _locations[4]),
  MapMarker(
      image: '${_path}vivo.png',
      title: 'Vivo',
      address: 'Địa chỉ Vivo',
      timming: 'Thời gian dự kiến : 3h40p',
      warning: 'Quá xa !!!',
      location: _locations[5]),
  MapMarker(
      image: '${_path}vsmart.png',
      title: 'Vsmart',
      address: 'Địa chỉ Vsmart',
      timming: 'Thời gian dự kiến : 2h10p',
      warning: '',
      location: _locations[6]),
  MapMarker(
      image: '${_path}huawei.png',
      title: 'Huawei',
      address:
          'Địa chỉ : Tầng 33, Keangnam Landmark, E6, đường Phạm Hùng, Mễ Trì, Nam Từ Liêm, Hà Nội',
      timming: 'Thời gian dự kiến : 2h',
      warning: '',
      location: _locations[7]),
  MapMarker(
      image: '${_path}lg.png',
      title: 'LG',
      address: 'Địa chỉ : Lô CN2, KCN Tràng Duệ, Lê Lợi, An Dương, Hà Nội',
      timming: 'Thời gian dự kiến : 10p',
      warning: '',
      location: _locations[8]),
  MapMarker(
      image: '${_path}sony.png',
      title: 'Sony',
      address:
          ' Địa chỉ : Lầu 6, Tòa nhà PetroVietnam, Số 1-5 Lê Duẩn, Phường Bến Nghé, Hà Nội',
      timming: 'Thời gian dự kiến : 30p',
      warning: '',
      location: _locations[9]),
];
