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
    return firestore
      .collection("cards")
      .doc(context.params.userId)
      .collection("sources")
      .doc(customerSource.card.fingerprint)
      .set(customerSource, { merge: true });
  });
