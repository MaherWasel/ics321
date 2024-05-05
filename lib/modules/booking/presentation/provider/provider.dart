import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/data/%20booking_repository.dart';
import 'package:ics321/modules/booking/domain/plane.dart';

abstract class BookingStates{}

class BookingIntial extends BookingStates{}

class BookingLoading extends BookingStates{}

class BookingFailure extends BookingStates{}

class BookingSuccess extends BookingStates{}

class BookingController extends StateNotifier<BookingStates> {
  BookingController(): super(BookingIntial());
  BookingRepository bookingRepository=BookingRepository();
  Plane? selectedPlane;
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
  
}
final bookingStateProvider = StateNotifierProvider<BookingController,BookingStates>((ref) {
  return BookingController();
});