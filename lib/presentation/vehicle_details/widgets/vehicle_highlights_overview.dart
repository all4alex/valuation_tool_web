import 'package:flutter/material.dart';
import 'package:valuation_tool_web/presentation/view_models/vehicle_highlights_vm.dart';

class VehicleHighlightsOverview extends StatelessWidget {
  VehicleHighlightsOverview({required this.highlightsList});
  final List<VehicleHighlightsVM> highlightsList;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width * .32 + 15,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
                spreadRadius: 0),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(
                'Highlights Overview',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff191919),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Container(
                height: highlightsList.length * 20,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: highlightsList.length,
                    itemBuilder: (BuildContext context, int i) {
                      VehicleHighlightsVM item = highlightsList[i];
                      return highlightItem(
                          item.isPositive!
                              ? Icon(Icons.check_circle_outline,
                                  size: 15, color: Colors.green)
                              : Icon(Icons.info_outline,
                                  size: 15, color: Colors.red),
                          item.description!);
                    }),
              ),
            ]));
  }

  Widget highlightItem(Icon icon, String text) {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 5),
          SelectableText(
            text,
            style: TextStyle(
                fontSize: 13,
                color: Color(0xff797979),
                overflow: TextOverflow.clip),
          ),
        ],
      ),
    );
  }
}
