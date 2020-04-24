<template>
  <div>
    
    <Purchase v-bind:startTime="startTime"
    v-bind:movieId="movieId"
    v-bind:selectedSeatNumbers="selectedSeatNumbers"
    v-bind:date="date"
    v-bind:price="price"></Purchase>

    <!--PurchaseReceipt generates & is emailed to customer, PurchaseReceipt is also able to be a bookmarked as a link -->
  </div>
</template>

<script>
import Purchase from "../components/Purchase";
export default {
  components: {
    Purchase
  },
  data() {
    return {
      movieId: 0,
      selectedSeatNumbers: ["No seats selected"],
      date: "no date", //YYYY-MM-DD
      startTime: "no time", //HH:MM
      price: 0
    };
  },

  created() {
    this.movieId = this.$route.params.id;
    if (this.$route.params.selectedSeats) {
      this.selectedSeatNumbers = this.$route.params.selectedSeats;
    }
    console.log(this.$route.params);
    this.date = this.$route.params.date
    this.startTime = this.$route.params.startTime
    this.price = this.$route.params.price
  }
};
</script>

<style>
</style>