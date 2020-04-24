using SmalltownCinemas.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.DAL
{
    public interface IMovieDAO
    {
        Movie GetMovieById(int id);
        IList<Movie> GetAllMovies();
    }
}
