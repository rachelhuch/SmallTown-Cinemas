<template>
  <div class="home">
    <section class="centeredPanel">
      <h1>Now Playing:</h1>

      <movie-tile
        v-for="m in movies"
        v-bind:key="m.movieId"
        v-bind:mTitle="m.title"
        v-bind:mPoster="m.poster"
        v-bind:mRated="m.rated"
        v-bind:mPlot="m.plot"
        v-bind:mActors="m.actors"
        v-bind:mGenre="m.genre"
        v-bind:mId="m.movieId"
        :isDetailPage="false"
      />

      <p></p>
    </section>
  </div>
</template>

<!--// import or connect to list of movies 
// display the list of movies -->


<script>
import MovieTile from "../components/MovieTile";
import Showings from "../components/Showings";

export default {
  name: "home",
  components: {
    MovieTile
  },
  data() {
    return {
      movies: [
        {
          id: 0,
          title: "",
          rated: "",
          plot: "",
          runtime: 0,
          actors: "",
          poster: "",
          genre: ""
        }
      ],
      Showings
    };
  },
  created() {
    let url = process.env.VUE_APP_REMOTE_API;
    url += "/api/movies";
    console.log("Generated url: " + url);
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
        console.table(json);
        this.movies = json;
      });
  }
};
</script>



<style>
body {
  background-image: url("../../src/backgroundimg.jpg");
}

</style>
