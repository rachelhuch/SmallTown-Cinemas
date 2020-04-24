<template>
  <div>
    <section id="centeredPanel">
      <div id="info">
        <h2>Receipt for Purchase #: {{purchaseId}}</h2>

        <p id="bold">Movie Title: {{receipt.title}}</p>

        <p>Number of Tickets: {{receipt.numTickets}}</p>
        <p>Customer Email: {{receipt.email}}</p>

        <p>Theater Number: {{receipt.theater}}</p>
        <p>Start Time: {{receipt.startTime}}</p>

        <p id="bold">Total Price: ${{receipt.totalPrice}}</p>
      </div>
      <div id="info2">
        <p class="list">Your reserved seats are:</p>
        <ul>
          <li v-bind:key="sn" v-for="sn in receipt.seatNumbers">{{sn}}</li>
        </ul>
        <p id="purchase">Purchase Timestamp: {{receipt.purchaseTimestamp}}</p>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: "PurchaseReceipt",
  data() {
    return {
      receipt: {
        purchaseId: 1,
        numTickets: 2,
        email: "John Movie",
        totalPrice: 100.0,
        theater: "1",
        startTime: "10:00 am April 16th, 2020",
        title: "Wreck-it ralph",
        seatNumbers: ["F1", "G4"],
        purchaseTimestamp: "11:10 am April 15th, 2020"
      },
      movieId: 0,
      userId: 0,
      theaterId: 0,
      showingId: 0,
      // formattedPrice: formatter.format(this.receipt.totalPrice)
    };
  },
  created() {
    this.purchaseId = this.$route.params.id;
    //here we will look up the API to get the purchase with the Id
    this.lookupReceipt();
  },
  methods: {
    lookupReceipt() {
      let url = process.env.VUE_APP_REMOTE_API;
      url += `/api/purchase/lookup/${this.purchaseId}`;
      fetch(url)
        .then(response => {
          return response.json();
        })
        .then(json => {
          this.receipt = json;
        });
    }
  }
};

// const formatter = new Intl.NumberFormat("en-US", {
//   style: "currency",
//   currency: "USD",
//   minimumFractionDigits: 2
// });
</script>

<style>
#centeredPanel {
  clear: both;
  display: block;
  width: 100%;
  min-height: 450px;
  max-width: 750px;
  background-color: white;
  border-color: black;
  border-style: solid;

  border-radius: 7px;
  margin: 20px auto;
  padding-top: 0.5px;
  padding-bottom: 50px;
  padding-right: 20px;
  padding-left: 20px;
  align-content: center;
  text-align: center;
}
#info {
  text-align: left;
}
#info2 {
  padding-top: 5px;
  text-align: center;
}
#purchase {
  padding-top: 5%;
}
.list {
  text-align: center;
}
#bold {
  font-weight: bold;
  text-align: center;
  border: 2px solid darkblue;
}
</style>