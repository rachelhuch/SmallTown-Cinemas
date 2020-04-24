<template>
  <div id="movie">
    <section v-if="this.displayKey > 0" v-bind:key="this.displayKey" class="centeredPanel">
      <h3>{{this.movie.Title}}</h3>
      <img class="poster" v-bind:src="this.movie.Poster" />
      <div id="movieBox">
        <h3>{{this.movie.Rated}} ({{this.movie.Genre}})</h3>
        <p>Starring: {{this.movie.Actors}}</p>
        <p>{{this.movie.Plot}}</p>
        <p></p>
        <p></p>
        <!-- <Showings v-bind:showings="this.showings"></Showings> -->
      </div>
    </section>
  </div>
</template>

<script>
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
      movies: []
    };
  },
  created() {
    let url = process.env.VUE_APP_REMOTE_API;
    url += `/api/movies/${this.$route.params.id}`;
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
        this.movie = json;
        this.displayKey += 1;
        console.log("display key updated, should refresh");
      });

    console.log(this.movie);
  }
};
</script>

<style>
</style>

<!--After I click on a movie title or poster, I land on this page
Should only display one movie & list of showings for next 7 days 
Should have a button to initiate ticket purchase workflow
 -->