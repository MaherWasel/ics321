import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/admin/data/admin_repository.dart';
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
}

final flightProvider = FutureProvider<List<FlightModel>>((ref) async {
  final response=await AdminRepositroy().getFlights();
  
  
  return response;}
  );
final adminControllerProvider  = StateNotifierProvider<AdminController,AdminStates>((ref) {
  return AdminController();
});