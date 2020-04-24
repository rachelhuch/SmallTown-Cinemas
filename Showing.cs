using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.Models
{
    public class Showing
    {
        public int ShowingId { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int MovieId { get; set; }
        public int TheaterId { get; set; }
        public string StartTimeFormatted { get; set; }

    }
}
