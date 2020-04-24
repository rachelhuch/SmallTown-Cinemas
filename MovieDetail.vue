<template>
  <div id="movie">
    <section class="centeredPanel">
      <div id="movieBox">
        <movie-tile
          v-if="this.movie.movieId > 0"
          v-bind:key="this.movie.movieId"
          v-bind:mTitle="this.movie.title"
          v-bind:mPoster="this.movie.poster"
          v-bind:mRated="this.movie.rated"
          v-bind:mPlot="this.movie.plot"
          v-bind:mActors="this.movie.actors"
          v-bind:mGenre="this.movie.genre"
          v-bind:mId="this.movie.movieId"
          :isDetailPage="true"
          v-on:display-tickets="displayTickets"
          v-on:new-date-selected="changeSelectedDate"
        />
        <ticket-selection
          v-on:selection-confirmed="displaySeatGrid"
          v-if="areTicketsDisplayed"
          v-bind:selectedStartTime="selectedStartTime"
          v-bind:key="selectedStartTime"
        ></ticket-selection>

        <seat-grid
          v-if="areSeatsDisplayed"
          v-bind:totalTickets="totalTickets"
          v-bind:reservedSeats="reservedSeats"
          :movieId="movie.movieId"
          :date="selectedDate"
          :startTime="selectedStartTime"
          :totalPrice="totalPrice"
        ></seat-grid>
      </div>
    </section>
  </div>
</template>

<script>
import MovieTile from "../components/MovieTile";
import SeatGrid from "../components/SeatGrid";
import TicketSelection from "../components/TicketSelection";

export default {
  data() {
    return {
      displayKey: 0,
      movie: {
        movieId: 0,
        Title: "",
        Poster: "",
        Rated: "",
        Genre: "",
        Actors: "",
        Plot: ""
      },
      mID: 0,
      movies: [],
      areTicketsDisplayed: false,
      areSeatsDisplayed: false,
      selectedStartTime: "",
      selectedDate: "",
      totalTickets: 0,
      reservedSeats: [],
      totalPrice: 0
    };
  },
  components: {
    MovieTile,
    SeatGrid,
    TicketSelection
  },
  formatDate(date) {
    let d = new Date(date),
      month = "" + (d.getMonth() + 1),
      day = "" + d.getDate(),
      year = d.getFullYear();

    if (month.length < 2) month = "0" + month;
    if (day.length < 2) day = "0" + day;
    console.log([year, month, day].join("-"));
  },
  methods: {
    displayTickets($event) {
      // console.log("display tickets");

      this.selectedStartTime = $event;
      this.areTicketsDisplayed = true;
      this.getReservedSeatsByMovieIdAndDateAndStartTime(
        this.movie["movieId"],
        this.selectedDate,
        this.selectedStartTime
      );
    },
    displaySeatGrid($event, price) {
      // console.log('display seats')
      // this.getReservedSeatsByShowing();
      console.log('display seat grid event in movie detail: start log')
      console.log('event: '+$event)
      console.log('price: '+price)
      console.log('display seat grid event in movie detail: end log')
      this.totalTickets = $event;
      this.areSeatsDisplayed = true;
      this.totalPrice = price;
    },
    changeSelectedDate($event) {
      console.log("received changeSelectedDateEvent with payload: " + $event);
      this.selectedDate = $event;
    },
    getReservedSeatsByMovieIdAndDateAndStartTime(movieId, date, startTime) {
      // fetch
      console.log("Begin getReservedSeats");
      console.log("movieId: " + movieId);
      console.log("date: " + date);
      console.log("startTime: " + startTime);

      let url = process.env.VUE_APP_REMOTE_API;
      url += `/api/purchase/${movieId}/${date}/${startTime}`;
      console.log("url to fetch from: " + url);
      fetch(url)
        .then(response => {
          return response.json();
        })
        .then(json => {
          this.reservedSeats = json;
        });
      console.log("end getResSeats");
    }
  },
  created() {
    let url = process.env.VUE_APP_REMOTE_API;
    url += `/api/movies/${this.$route.params.id}`;
    // console.log("Generated url: " + url);
    fetch(url)
      .then(response => {
        if (!response.ok) {
          console.log("Response status: " + response.status);
          console.log("Response status text: " + response.statusText);
          throw new Error("Netw. response not ok");
        }
        return response.json();
      })
      .then(json => {
        // console.table(json);
        this.movie = json;
        this.displayKey += 1;
        // console.log("display key updated, should refresh");
      });

    // console.log(this.movie);
  }
};
</script>

<style>
#movieBox {
  padding-top: 50px;
}
</style>

<!--After I click on a movie title or poster, I land on this page
Should only display one movie & list of showings for next 7 days 
Should have a button to initiate ticket purchase workflow
 -->