import 'package:contacts_app_new/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../bussines_logic/app_cubit.dart';

class FavouriteItem extends StatelessWidget {

  final Map model;

   FavouriteItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
         key: Key(model['id'].toString()),
         child: InkWell
           (
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 4.w),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                 gradient:  const LinearGradient(
                   begin: AlignmentDirectional.topStart,
                     end: AlignmentDirectional.bottomEnd,
                     colors: [
                       lightPurple,
                       black,
                     ],
                 ),
               ),
               child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                         Flexible(
                           child: Padding(
                             padding: const EdgeInsetsDirectional.only(start: 2),
                             child: Text('${model['name']}',
                             style: TextStyle(
                               fontSize: 14.sp,
                               fontWeight: FontWeight.bold,
                               color: white,
                             ),
                             ),
                           ),
                         ),
                           Flexible(
                             child: Text('${model['PhoneNumber']}',
                               style: TextStyle(
                                 fontSize: 14.sp,
                                 fontWeight: FontWeight.normal,
                                 color: white,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     const Spacer(),
                     IconButton(
                           onPressed: (){
                             AppCubit.get(context).addOrRemoveFavourite(
                                status: 'all',
                                 id: model['id'],
                            );
                             },
                                icon: const Icon(Icons.favorite,color: Colors.red,),
                     ),
                   ],
                 ),
               ),
             ),
         ),
      onDismissed: (direction) {
           AppCubit.get(context).deleteContact(id:model['id']);
           Fluttertoast.showToast(
               msg: 'Contact deleted Successfully!',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 2,
             backgroundColor: Colors.green,
             textColor: darkBlue,
             fontSize: 14.sp,
           );
      },
    );
  }
}
