import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/admin/data/admin_repository.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:ics321/shared/models/flight.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:ics321/shared/models/ticket.dart';

abstract class AdminStates {}
class AdminLoading extends AdminStates{}
class AdminIntial extends AdminStates{}
class AdminSuccess extends AdminStates{}
class AdminFailure extends AdminStates{}
class AdminController extends StateNotifier<AdminStates> {
  AdminController(): super(AdminIntial());
  final AdminRepositroy adminRepo=AdminRepositroy();
  Future<Plane?> getPlane({required String planeId})async {
    try{
      state=AdminLoading();
      final response = await adminRepo.getPlane(planeId: planeId);
      state = AdminSuccess();
      return response;
    }
    catch(e){

      state=AdminFailure();
    }
  }
  Future<List<Ticket>?> getFlightTickets({required FlightModel flight})async {
    try{
      state=AdminLoading();
      final response = await adminRepo.getTicketsForFlight(flight: flight);
      state = AdminSuccess();
      return response;
    }
    catch(e){
      print(e);
      state=AdminFailure();
    }
  }
  Future<List<FlightModel>?> getFlightReport({required DateTime date})async {
    try{  
      state=AdminLoading();
      final response = await adminRepo.getBookedPercentagesForFlights(date: date);
      state=AdminSuccess();
      return response;
    }
    catch(e){
      print(e);
      state=AdminFailure();
    }
  }

Future<List<Plane>?> getPlaneReport({required DateTime date})async {
    try{  
      state=AdminLoading();
      final response = await adminRepo.getPlaneReports(date: date);
      state=AdminSuccess();
      return response;
    }
    catch(e){
      print(e);
      state=AdminFailure();
    }
  }
  Future<List<Ticket>?> getWaitListedTickets({required FlightModel flight})async {
    try{  
      state=AdminLoading();
      final response = await adminRepo.getWaitListedTickets(flight: flight);
      state=AdminSuccess();
      return response;
    }
    catch(e){
      print(e);
      state=AdminFailure();
    }
  }
  Future<List<Seat>?> getAvailableSeats({required String flight_id, String? status,String? type,required  String class_type})async{
    try{
      state=AdminLoading();
      final respone = await adminRepo.getAvailableSeats(flight_id: flight_id,type: type,status: status,class_type: class_type);
      state=AdminSuccess();

      return respone;
    } 
    catch(e){
      print(e);
      state=AdminFailure();

      

    }

  }
  
  Future<void> changeWaitList({required Ticket ticketId ,required String seatLocation})async {
    try{
      state=AdminLoading();
        await adminRepo.changeWaitList(ticketId: ticketId,seatLocation: seatLocation);
      state=AdminSuccess();


    } 
    catch(e){
      print(e);
      state=AdminFailure();

      

    }

  }
}




final flightProvider = FutureProvider<List<FlightModel>>((ref) async {
  final response=await AdminRepositroy().getFlights();
  
  
  return response;}
  );
final adminControllerProvider  = StateNotifierProvider<AdminController,AdminStates>((ref) {
  return AdminController();
});