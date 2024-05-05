import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/home/data/home_repository.dart';
import 'package:ics321/shared/models/flight.dart';

abstract class HomeStates {}

class HomeIntial extends HomeStates{}
class HomeLoading extends HomeStates{}
class HomeSuccess extends HomeStates{}
class HomeFailure extends HomeStates{}


class HomeController extends StateNotifier<HomeStates> {
  final HomeRepository homeRepository= HomeRepository();
  HomeController(): super(HomeIntial());
   List<FlightModel> listOfFlight=[];
   String inputEmail="";
   String inputName="";
   List<String> uniqueSources=[];
    List<String> uniqueDestinations=[];
  Future<List<FlightModel>> getAllFlights()async {
    state=HomeLoading();
    final response = await homeRepository.getAllFlights();
    for (int i=0;i<response.length;i++){
              if (!uniqueSources.contains(response[i].source) ){
                uniqueSources.add(response[i].source);
              }
              if (!uniqueDestinations.contains(response[i].destination)){
                uniqueDestinations.add(response[i].destination);
              }
            }
    state=HomeSuccess();
    listOfFlight=response;
    return listOfFlight;
  }
  Future<void> updateUserInfo({ String? email, String? name})async{
    try{
      state=HomeLoading();
      await homeRepository.updateUserInfo(email: email, name: name);
      Utils.user?.email=email;
      Utils.user?.name=name;
      state=HomeSuccess();
    }
    catch (e){
      state=HomeFailure();
      print("maher");
      print(e);

    }
  }
    List<FlightModel> filterFlights({ DateTime? date,String? source,String? destination}){
      return homeRepository.filterFlights(listOfFlights: listOfFlight,date: date,source: source,destination: destination);
    }

}
final homeControllerProvider = StateNotifierProvider<HomeController,HomeStates>((ref) {
  return HomeController();
});

class BottomBarController extends StateNotifier<int> {
  BottomBarController(): super(0);
  void modifyBarIndex({required int index}){
    state=index;
  }
  
}
final bottomBarProvider = StateNotifierProvider<BottomBarController,int>((ref) {
  return BottomBarController();
});