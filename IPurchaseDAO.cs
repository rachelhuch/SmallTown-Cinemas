using SmalltownCinemas.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.DAL
{
    public interface IPurchaseDAO
    {
        List<Ticket> GetReservedSeatsByShowingId(int showingId);
        List<Ticket> GetReservedSeats(int movieId, string date, string startTime);
        Purchase CreateNewPurchase(double totalPrice, int userId);
        int CreateNewTickets(int purchaseId, int showingId, List<string> seatNumbers, double price);
        void AdminSetupPurchasesAndTickets();
        Receipt GetPurchaseInfoForReceipt(int purchaseId);
    }
}
