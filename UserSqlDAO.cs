using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.DAL
{
    public class UserSqlDAO : IUserDAO
    {
        private readonly string connectionString;

        public UserSqlDAO(string connString)
        {
            this.connectionString = connString;
        }
        public int GetUserIdByEmailAddress(string email)
        {
            int userId = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = "SELECT UserId FROM Users Where Email = @email";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@email", email);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                        userId = Convert.ToInt32(rdr["userId"]);
                    }
                    else
                    {
                        rdr.Close();
                        string sql2 = @"insert into users
                                        (email, password)
                                        values
                                        (@email, 'password')
                                        select @@IDENTITY";
                        SqlCommand cmd2 = new SqlCommand(sql2, conn);
                        cmd2.Parameters.AddWithValue("@email", email);
                        userId = Convert.ToInt32(cmd2.ExecuteScalar());
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return userId;
        }
    }
}
