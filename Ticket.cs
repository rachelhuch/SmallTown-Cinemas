using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.Models
{
    public class Ticket
    {
        public int TicketId { get; set; }
        public int ShowingId { get; set; }
        public string SeatName { get; set; }
        public int PurchaseId { get; set; }
        public double Price { get; set; }
    }
}
