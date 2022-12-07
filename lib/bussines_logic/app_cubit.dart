import 'package:contacts_app_new/presentation/screens/contacts/contacts_screen.dart';
import 'package:contacts_app_new/presentation/screens/favourite/favourite_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.person_add;

  List<Widget> Screens =[
    const ContactsScreen(),
    const FavouriteScreens(),
  ];

  List<String> appbartitles = [
    'Contacts',
    'Favourite'
  ];
  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBNBState());
  }
  List<Map> contacts = [];
  List<Map> favourite = [];
   void ChangeBottomSheetState ({
     required bool isShown,
     required IconData icon,
}){
     isBottomSheetShown = isShown;
     fabIcon = icon;
     emit(AppChangeBSState());
   }
late Database database;
   void CreateDatabase(){
     openDatabase(
         'contacts.db',
       version: 1,
       onCreate: (database,version){
           if (kDebugMode) {
             print('database create');
           }
           database.execute(
               'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, phoneNumber TEXT,status TEXT  )'
           ).then((value) {
             if (kDebugMode) {
               print('table is created');
             }
           }).catchError((error){
             if (kDebugMode) {
               print('Error at creating $error');
             }
           });
       },
       onOpen: (database){
           getDataFromDatabase(database);
           if (kDebugMode) {
             print('database opened');
           }
       }
     ).then((value) {
       database = value;
       emit(AppChangeBNBState());
     });
   }
void getDataFromDatabase(database){
     contacts = [];
     favourite = [];
     emit(AppGetDataBaseLoadingState());
     database.rawQuery('SELECT * FROM contacts ').then((value){

       value.forEach((element){
         contacts.add(element);
         
         if (element['status'] == 'favourite') {
           favourite.add(element);
         }  
       });
       emit(AppGetDataBaseState());
     });
   }
   insertToDatabase({required String name, required String phoneNumber}) async{
     await database.transaction((txn) {
       return txn.rawInsert(
           'INSERT INTO contacts(name,phoneNumber,status) VALUES("$name", "$phoneNumber","all")'
       ).then((value) {
         if (kDebugMode) {
           print('contact $value successfully inserted!');
           emit(AppInsertContactState());
           getDataFromDatabase(database);
         }
       }).catchError((error){
         if (kDebugMode) {
           print('Error when inserting to data $error');
         }
       });
     });
   }
   void addOrRemoveFavourite({
  required String status,
     required int id,
}) {
    database.rawUpdate('UPDATE contacts SET status = ? WHERE id = ?',
    [status,id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppAddOrRemoveFavouriteContactState());
    });
   }
   void editContact({
  required String name,
     required String phoneNumber,
     required int id,
}){
     database.rawUpdate('UPDATE contacts SET name = ?, phoneNumber = ? WHERE id = ?',
     [name,phoneNumber,id]
     ).then((value) {
       getDataFromDatabase(database);
       emit(AppEditContactState());
     });
   }
   void deleteContact({
  required int id,
}){
     database.rawDelete('DELETE FROM contacts WHERE id = ?',
     [id]
     ).then((value) {
       getDataFromDatabase(database);
       emit(AppDeleteContactsState());
     });
   }
}
