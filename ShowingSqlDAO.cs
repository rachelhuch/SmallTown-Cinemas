using SmalltownCinemas.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.DAL
{
    public class ShowingSqlDAO : IShowingDAO
    {
        private readonly string connectionString;
        public ShowingSqlDAO(string connString)
        {
            this.connectionString = connString;
        }

        public IList<Showing> GetAllShowings()
        {
            IList<Showing> showings = new List<Showing>();
            try
            {
                using (SqlConnection conn = new SqlConnection(this.connectionString))
                {
                    conn.Open();

                    string sql = "SELECT * FROM SHOWINGS WHERE starttime > @currentTime";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@currentTime", DateTime.Now);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        showings.Add(RowToShowing(rdr));
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return showings;
        }

        public void GenerateAllShowings()
        {
            List<Screen> screens = new List<Screen>();
            screens.Add(new Screen(142, 0, 1, 1));
            screens.Add(new Screen(142, 5, 1, 2));
            screens.Add(new Screen(124, 0, 2, 3));
            screens.Add(new Screen(124, 5, 2, 4));
            screens.Add(new Screen(141, 0, 3, 5));
            screens.Add(new Screen(141, 5, 3, 6));
            screens.Add(new Screen(141, 10, 3, 7));
            foreach (var screen in screens)
            {
                screen.AddShowtimes();
            }
            try
            {
                using (SqlConnection conn = new SqlConnection(this.connectionString))
                {
                    conn.Open();

                    string sql = "delete from showings";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.ExecuteNonQuery();

                    //TODO: add insertion logic and looping
                    foreach (Screen s in screens)
                    {
                        foreach (DateTime t in s.StartTimes)
                        {
                            string sql2 = @"insert into Showings
                                    (MovieId, StartTime, EndTime, TheaterId)
                                    values
                                    (@movieId, @startTime, @endTime, @theaterId)";
                            SqlCommand cmd2 = new SqlCommand(sql2, conn);
                            cmd2.Parameters.AddWithValue("@movieId", s.MovieId);
                            cmd2.Parameters.AddWithValue("@startTime", t);
                            cmd2.Parameters.AddWithValue("@endTime", t.AddMinutes(s.Runtime));
                            cmd2.Parameters.AddWithValue("@theaterId", s.TheaterId);
                            cmd2.ExecuteNonQuery();
                        }
                    }


                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        private Showing RowToShowing(SqlDataReader rdr)
        {
            Showing showing = new Showing();
            showing.ShowingId = Convert.ToInt32(rdr["ShowingId"]);
            showing.MovieId = Convert.ToInt32(rdr["MovieId"]);
            showing.TheaterId = Convert.ToInt32(rdr["TheaterId"]);
            showing.StartTime = Convert.ToDateTime(rdr["StartTime"]);
            showing.StartTimeFormatted = showing.StartTime.ToShortTimeString();
            showing.EndTime = Convert.ToDateTime(rdr["EndTime"]);
            //showing.ShowingId = Convert.ToInt32(rdr["ShowingId"]);
            return showing;
        }

        public IList<Showing> GetShowingsByMovieId(int movieId, string date = "")
        {
            if (date == "")
            {
                date = $"{DateTime.Now:yyyy-MM-dd}";
            }


            IList<Showing> showings = new List<Showing>();
            try
            {
                using (SqlConnection conn = new SqlConnection(this.connectionString))
                {
                    conn.Open();

                    string sql = @"
select * from Showings 
where MovieId = @id 
and starttime > @currentTime 
and (convert(date,starttime)) = @selectedDate
order by starttime";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", movieId);
                    cmd.Parameters.AddWithValue("@currentTime", DateTime.Now);
                    cmd.Parameters.AddWithValue("@selectedDate", date);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        showings.Add(RowToShowing(rdr));
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return showings;
        }

        public int GetShowingId(int movieId, string date, string startTime)
        {
            int showingId = 0;
            string dateTime = date + " " + startTime;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = @"select showingid from showings 
                            where movieId = @mid
                            and StartTime = @stime";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@mid", movieId);
                    cmd.Parameters.AddWithValue("@stime", dateTime);

                    showingId = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch (Exception)
            {

                throw;
            }

            return showingId;
        }
    }
}