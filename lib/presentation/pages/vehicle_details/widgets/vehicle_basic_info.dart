import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VehicleBasicInfo extends StatefulWidget {
  VehicleBasicInfo(
      {required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.vin});
  final String imageUrl;
  final String title;
  final String subTitle;
  final String vin;

  @override
  State<VehicleBasicInfo> createState() => _VehicleBasicInfoState();
}

class _VehicleBasicInfoState extends State<VehicleBasicInfo> {
  String imageUrl = '';

  @override
  void initState() {
    imageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 170,
          height: 110,
          color: Colors.grey,
          child: imageUrl.isEmpty
              ? Image.asset('assets/images/no_image.jpeg')
              : CachedNetworkImage(imageUrl: imageUrl),
        ),
        const SizedBox(width: 10),
        Container(
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(
                widget.title,
                style: TextStyle(
                    color: Color(0xff494949),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SelectableText(widget.subTitle,
                  style: TextStyle(fontSize: 12, color: Color(0xff777777))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    'VIN: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SelectableText(
                    widget.vin,
                    style: TextStyle(color: Color(0xff777777), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
