// Firebase тохиргоо
const firebaseConfig = {
  apiKey: "AIzaSyDQIYDk2MdXvVo0x_TMPG_XcMj6AVRSpig",
  authDomain: "oyunsanaa-burtgel.firebaseapp.com",
  projectId: "oyunsanaa-burtgel",
  storageBucket: "oyunsanaa-burtgel.appspot.com",
  messagingSenderId: "xxx",
  appId: "xxx",
  measurementId: "xxx"
};

// Firebase-г эхлүүлэх
firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

// Бүртгэлийн форм дээр submit хийхэд Firestore руу хадгалах
document.getElementById("registrationForm").addEventListener("submit", async function(e) {
  e.preventDefault();

  const name = document.getElementById("name").value;
  // бусад утгуудыг авч байна...

  try {
    await db.collection("registration").add({
      name,
      // бусад талбарууд
      timestamp: new Date()
    });
    alert("Бүртгэл амжилттай!");
  } catch (error) {
    alert("Алдаа гарлаа: " + error.message);
  }
});
