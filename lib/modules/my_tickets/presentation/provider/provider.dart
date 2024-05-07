
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/my_tickets/data/ticket_repository.dart';
import 'package:ics321/modules/my_tickets/domain/ticket.dart';

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
  
}
final myTicketsProvider = StateNotifierProvider<TicketController,TicketsStates>((ref) {
  return TicketController();
});