using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.Models
{
    public class Screen
    {
        public int Runtime { get; private set; }
        public int Gap { get; } = 15;
        public int Offset { get; private set; }
        public List<DateTime> StartTimes { get; set; }
        public int MovieId { get; set; }
        public int TheaterId { get; set; }

        public Screen(int runtime, int startOffset, int movieId, int theaterId)
        {
            this.Runtime = runtime;
            this.Offset = startOffset;
            this.MovieId = movieId;
            this.TheaterId = theaterId;
            StartTimes = new List<DateTime>();
        }

        public void AddShowtimes()
        {
            DateTime startDate = DateTime.Now.Date;
            DateTime currDate = startDate;
            DateTime startTime = currDate.AddHours(10).AddMinutes(Offset);

            while (currDate.AddDays(1) < startDate.AddDays(8))
            {

                DateTime latestStart = currDate.AddHours(22);


                if (CanAnotherShowtimeBeAdded(latestStart))
                {
                    StartTimes.Add(startTime);
                    startTime = startTime.AddMinutes(Runtime + Gap);
                    startTime = RoundStartTimeToNext15(startTime);
                }
                else
                {
                    currDate = currDate.AddDays(1);
                    startTime = currDate.AddHours(10).AddMinutes(Offset);
                }
            }
        }

        private DateTime RoundStartTimeToNext15(DateTime startTime)
        {
            int startMins = startTime.Minute;
            int minsMod5 = startMins % 5;
            //if (startMins == 0 || startMins == 15 || startMins == 30 || startMins == 45)
            //{
            //    return startTime;
            //}
            //if (startMins < 15)
            //{
            //    startTime = startTime.AddMinutes(15 - startMins);
            //}
            //else if (startMins < 30)
            //{
            //    startTime = startTime.AddMinutes(30 - startMins);
            //}
            //else if (startMins < 45)
            //{
            //    startTime = startTime.AddMinutes(45 - startMins);
            //}
            //else
            //{
            //    startTime = startTime.AddMinutes(60 - startMins);
            //}
            if (minsMod5 == 0)
            {
                return startTime;
            }
            startTime = startTime.AddMinutes(5 - minsMod5);
            return startTime;
        }

        public bool CanAnotherShowtimeBeAdded(DateTime latestStart)
        {
            if (StartTimes.Count == 0)
            {
                return true;
            }

            foreach (var time in StartTimes)
            {
                if (time.AddMinutes(Runtime + Gap) > latestStart)
                {
                    return false;
                }

            }

            return true;
        }

        public void PrintShowtimes()
        {
            foreach (var time in StartTimes)
            {
                Console.WriteLine($"{time} -> {time.AddMinutes(Runtime)}");
            }
        }
    }
}
