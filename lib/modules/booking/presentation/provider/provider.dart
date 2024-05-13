import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/data/%20booking_repository.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:ics321/modules/booking/domain/seat.dart';

abstract class BookingStates{}

class BookingIntial extends BookingStates{}

class BookingLoading extends BookingStates{}

class BookingFailure extends BookingStates{}

class BookingSuccess extends BookingStates{}

class BookingController extends StateNotifier<BookingStates> {
  BookingController(): super(BookingIntial());
  BookingRepository bookingRepository=BookingRepository();
  Plane? selectedPlane;
  String selectedType="";
  Future<void> getPlane({required String planeId})async {
    try{
      state=BookingLoading();
      selectedPlane = await bookingRepository.getPlane(planeId: planeId);
      state = BookingSuccess();

    }
    catch(e){
      print(e);
      state=BookingFailure();
    }
  }
  Future<List<Seat>?> getAvailableSeats({required String flight_id, String? status,String? type,})async{
    try{
      state=BookingLoading();
      final respone = await bookingRepository.getAvailableSeats(flight_id: flight_id,type: type,status: status);
      state=BookingSuccess();

      return respone;
    } 
    catch(e){

      state=BookingFailure();

      

    }

  }
  Future<void> sendTicket({required String flight_id,required double price,required String? seatLocation, String? status})async {
    try{
      state=BookingLoading();
      await bookingRepository.sendTicket(flight_id: flight_id, price: price, seatLocation: seatLocation,status: status,classType: selectedType);
      state=BookingSuccess();

   } 
    catch(e){

      state=BookingFailure();
    }

  }
  
}
final bookingStateProvider = StateNotifierProvider.autoDispose<BookingController,BookingStates>((ref) {

  return BookingController();
});