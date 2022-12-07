import 'package:contacts_app_new/bussines_logic/app_cubit.dart';
import 'package:contacts_app_new/presentation/styles/colors.dart';
import 'package:contacts_app_new/presentation/widgets/default_phone_form_field.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeLayout extends StatelessWidget {

  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var myCountryCode = CountryCode(name: 'EG', dialCode: '+20');

  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
       if (state is AppInsertContactState) {
         Navigator.pop(context);
       }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          key: ScaffoldKey,
          appBar: AppBar(
            backgroundColor: darkSkyBlue,
            centerTitle: true,
            title: Text(cubit.appbartitles[cubit.currentIndex],
              style: const TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors:[
                      skyBlue,
                      lightPurple,
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding:  EdgeInsets.all(8.sp),
                child: BlocBuilder<AppCubit,AppState>(
                    builder: (context, state){context;
                      if (state is AppGetDataBaseLoadingState) {
                        return const CircularProgressIndicator(color: white,);
                      } else {
                        return cubit.Screens[cubit.currentIndex];
                      }
                    }
                ),
              ) ],
              ),
          floatingActionButton: FloatingActionButton(
            elevation: 20,
            backgroundColor: darkSkyBlue,
            child: Icon(cubit.fabIcon,
              color: lightBlue,
            ),
            onPressed: () async{
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  await cubit.insertToDatabase(
                    name: nameController.text,
                    phoneNumber: '${myCountryCode.dialCode}${phoneNumberController.text}'
                  );
                  nameController.text = '';
                  phoneNumberController.text = '';
                }
              }else{
                ScaffoldKey.currentState!.showBottomSheet(
                        (context) => Wrap(
                          children: [
                            Container(
                              color: darkSkyBlue,
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h,horizontal: 3.w
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if (value!.isEmpty) {
                                          return "Name mustn't be empty";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                      suffixIcon:Icon(
                                          Icons.title_outlined
                                      ),
                                        labelText: 'Contact Name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                   DefaultPhoneFormField(
                                     controller: phoneNumberController,
                                     valdiator: (value){
                                       if (value!.isEmpty) {
                                         return " Phone Number mustn't be empty";
                                       }
                                       return null;
                                     },
                                     labelText: 'Contact Phone Number',
                                     textColor: white,
                                     labelColor: white,
                                     onChange: (countryCode){
                                      myCountryCode = countryCode;
                                     },
                                   )
                                  ],
                                ) ,
                              ),
                            ),
                          ],
                        )
                ).closed.then((value) {
                  cubit.ChangeBottomSheetState(isShown: false, icon: Icons.person_add);
                });
                cubit.ChangeBottomSheetState(isShown: true, icon: Icons.add);
              }
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: darkSkyBlue,
            elevation: 0,
            shape: const CircularNotchedRectangle() ,
            notchMargin: 6,
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
              onTap: (index){
                cubit.changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: lightSkyBlue,
              unselectedItemColor: lightBlue,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.contacts_outlined),
                  label: 'Contacts'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                  label: 'Favourite'
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
