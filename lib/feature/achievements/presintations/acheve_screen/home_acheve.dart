import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constent/app_theme.dart';

class HomeAcheve extends StatelessWidget {
  const HomeAcheve({super.key});
// المعدل النجاح الكلي
  // عدد العادات المكتملة
  //ال عادات المكتملة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Achievement',
            style: Theme.of(context).textTheme.titleLarge),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              )
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration:  const BoxDecoration(
                gradient: AppTheme.mainGradient,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              ),
              height: 200.h,
              child: Column(
                children: [
                  Text('Achievements',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.surfaceCard,fontWeight: FontWeight.w400),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        children: [
                          Text('Num of habits completed',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.surfaceCard),),
                          const SizedBox(height: 6,),
                          Text('25 Time',style: TextStyle(
                            color: AppTheme.surfaceCard,
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),)

                        ],
                      ),
                      Container(width: 2,
                      color: AppTheme.surfaceCard,
                      height: 120,),
                      Column(
                        children: [
                          Text('Completion rate',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.surfaceCard),),
                          const SizedBox(height: 6,),
                          Row(
                            children: [
                              Icon(Icons.thumb_up,size: 30,
                                color: AppTheme.surfaceCard,),
                              const SizedBox(width: 6,),
                              Text('25%',style: TextStyle(
                                  color: AppTheme.surfaceCard,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ),)
                            ],
                          )
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
           SizedBox(height: 10,),
           Text('Habits Accomplished',
             style: Theme.of(context).textTheme.titleLarge,),

           const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                return Card(
                  child:
                  ListTile(
                    leading: Icon(Icons.water_drop,color: AppTheme.primaryBlue,),
                    trailing: Icon(Icons.done,
                        color: AppTheme.primaryMint,size: 30,),
                    title: Row(
                      children: [
                        Text('Water'),
                        const SizedBox(width: 6,),
                        Text('2025/9/28'),

                      ],
                    ),
                  ),
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}
