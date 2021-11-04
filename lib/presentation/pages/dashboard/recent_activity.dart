import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valuation_tool_web/presentation/widgets/user_avatar.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({Key? key}) : super(key: key);

  Widget activityItem(String activity) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  profilePicture: '',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '@john_doe',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          '9-23-2021 - 1:52 pm - (19 hours ago)',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Activity:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          activity,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print(screenSize.width / 4);
    return Container(
      height: screenSize.height / 1.23,
      width: screenSize.width / 1.4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF3F3F3),
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
        children: [
          Container(
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 15,
                    width: 15,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.zero,
                    child: SvgPicture.asset('assets/svg/sort_desc_icon.svg'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          activityItem(
              'Changed the target bid price to \$30,000 on 2020 Lexus NX'),
          activityItem(
              'Changed the mileage from \$26,500 to \$30,000 condition from average to rough on a 2020 GMC Yukon'),
          activityItem(
              'Changed the target bid price to \$30,000 on 2020 Lexus NX'),
          activityItem(
              'Changed the mileage from \$26,500 to \$30,000 condition from average to rough on a 2020 GMC Yukon'),
          const Divider(),
          SizedBox(
            height: 5,
          ),
          Text(
            'VIEW ALL ACTIVITIES',
            style: TextStyle(
                color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
