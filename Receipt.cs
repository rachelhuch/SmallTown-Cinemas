using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.Models
{
    public class Receipt
    {
        public Receipt()
        {
            SeatNumbers = new List<string>();
        }
        public int PurchaseId { get; set; }
        public string Email { get; set; }
        public int Theater { get; set; }
        public double TotalPrice { get; set; }
        public string StartTime { get; set; }
        public string Title { get; set; }
        public List<string> SeatNumbers { get; set; }
        public string PurchaseTimestamp { get; set; }
        public int NumTickets
        {
            get
            {
                return this.SeatNumbers.Count;
            }
        }
    }
}
