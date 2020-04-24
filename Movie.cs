using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmalltownCinemas.Models
{
    /// <summary>
    /// A movie object
    /// </summary>
    public class Movie
    {
        public Movie()
        {

        }

        public Movie(int movieId,string title, string rating, string plot, string cast, int runtime, string imdbId, string posterURL, string genre)
        {
            this.Title = title;
            this.Rated = rating;
            this.Plot = plot;
            this.Runtime = $"{runtime}";
            this.imdbID = imdbId;
            this.Genre = genre;
            //string[] actors = cast.Split(',');
            //List<string> cst = new List<string>();
            //foreach (string a in actors)
            //{
            //    cst.Add(a.Trim());
            //}
            this.Actors = cast;
            this.MovieId = movieId;
            this.Poster = posterURL;
        }

        /// <summary>
        /// The id of the movie in the SQL database
        /// </summary>
        public int MovieId { get; set; }

        /// <summary>
        /// The title of the movie
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// The movie's MPAA rating
        /// </summary>
        public string Rated { get; set; }

        /// <summary>
        /// A summary of the movie's plot
        /// </summary>
        public string Plot { get; set; }

        /// <summary>
        /// A list containing the names of the top-billed actors/actresses
        /// </summary>
        public string Actors { get; set; }

        /// <summary>
        /// The movie's runtime in minutes
        /// </summary>
        public string Runtime { get; set; }

        /// <summary>
        /// The IMDB id of the movie
        /// </summary>
        public string imdbID { get; set; }

        /// <summary>
        /// The URL of the poster image
        /// </summary>
        public string Poster { get; set; }

        public string Genre { get; set; }

    }
}
