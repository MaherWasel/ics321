
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/my_tickets/data/ticket_repository.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/shared/models/plane.dart';

abstract class TicketsStates {}

class TicketIntial extends TicketsStates{}
class TicketLoading extends TicketsStates{}
class TicketSuccess extends TicketsStates{}
class TicketFailure extends TicketsStates{}


class TicketController extends StateNotifier<TicketsStates> {
  TicketController(): super(TicketIntial());
  TicketRepository ticketRepository=TicketRepository();
  Future<List<Ticket>?> getTickets({required String userId})async {
    try{
      state =TicketLoading();
      final response = ticketRepository.getTickets(userId: userId);
      state = TicketSuccess();
      return response;
    }
    catch(e){
      state = TicketFailure();
    }
  }
  Future<void> payTicket({required Ticket ticket,required String user_id})async{
    try{

    state=TicketLoading();
    await ticketRepository.payTicket(ticketId: ticket, user_id: user_id);

    state=TicketSuccess();
    }
    catch(e){
      state=TicketFailure();
      print(e);
    }
  }
  Future<Plane?> getPlane({required String planeId})async {
    try{
      state=TicketLoading();
      final response = await ticketRepository.getPlane(planeId: planeId);
      state = TicketSuccess();
      return response;
    }
    catch(e){
      print(e);
      state=TicketFailure();
    }
  }
  Future<void> cancelTicket({required Ticket ticket})async {
    try{
      state=TicketLoading();
      await ticketRepository.cancelTicket(ticket: ticket);
      state=TicketSuccess();
    }
    catch(e){
      state =TicketFailure();
    }
  }
  
}
final myTicketsProvider = StateNotifierProvider<TicketController,TicketsStates>((ref) {
  return TicketController();
});
final myTicketPaymentProvider = StateNotifierProvider<TicketController,TicketsStates>((ref) {
  return TicketController();});