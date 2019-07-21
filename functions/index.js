const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

const firestore = admin.firestore();
const settings = { timestampInSnapshots: true };
firestore.settings(settings);

const stripe = require("stripe")(functions.config().stripe.token);

exports.addPaymentCourse = functions.firestore
  .document("cards/{userId}/tokens/{tokenId}")
  .onWrite(async (change, context) => {
    const data = change.after.data();
    if (data === null) {
      return null;
    }
    const token = data["tokenID"];
    const snapshot = await firestore
      .collection("cards")
      .doc(context.params.userId)
      .get();
    const dataSnap = snapshot.data();
    const emailID = dataSnap["email"];
    const custID = dataSnap["custId"];
    var customer;
    if (custID === "new") {
      customer = await stripe.customers.create({
        email: emailID,
        source: token
      });

      firestore
        .collection("cards")
        .doc(context.params.userId)
        .update({ custId: customer.id });
      
    } else {
      customer = await stripe.customers.retrieve(custID);
    }
    const customerSource = customer.sources.data[0];
    firestore.collection("cards").doc(context.params.userId).set({currentFinger: customerSource.card.fingerprint},{merge:true});
    return firestore
      .collection("cards")
      .doc(context.params.userId)
      .collection("sources")
      .doc(customerSource.card.fingerprint)
      .set(customerSource, { merge: true });
  });

exports.createStripeCharge = functions.firestore
  .document("cards/{userId}/charges/{chargeId}")
  .onCreate(async (change, context) => {
    try {
      //get the customer..to talk with Stripe...
      const snapshot = await firestore
        .collection("cards")
        .doc(context.params.userId)
        .get();
      const customer = snapshot.data()["custId"];
      const snapshotCharge = await firestore
        .collection("cards")
        .doc(context.params.userId)
        .collection("charges")
        .doc(context.params.chargeId)
        .get();
      const amount = change.data()["amount"];
      const currency = change.data()["currency"];
      const description = change.data()["description"];

      const charge = { amount, currency, customer, description };
      const idempotentKey = context.params.chargeId;

      const response = await stripe.charges.create(charge, {
        idempotency_key: idempotentKey
      });
      return change.ref.set(response, { merge: true });
    } catch (error) {
      console.error(error);
      await change.ref.set(
        { error: userFacingMessage(error) },
        { merge: true }
      );
      return null;
    }
  });
