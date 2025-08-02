// Firebase initialize (өргөдлийн дагуу өөрчилнө)
const app = firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

const chatToggle = document.getElementById("chatToggle");
const registrationSection = document.getElementById("registrationSection");
const chatSection = document.getElementById("chatSection");
const registrationForm = document.getElementById("registrationForm");
const registrationMessage = document.getElementById("registrationMessage");
const logoutBtn = document.getElementById("logoutBtn");
const chatbox = document.getElementById("chatbox");
const chatInput = document.getElementById("chatInput");
const sendBtn = document.getElementById("sendBtn");

let currentUserCode = null;

// Чат эхлэх товч дарвал
chatToggle.addEventListener("click", async () => {
  if (!currentUserCode) {
    // Бүртгэлтэй эсэхийг шалгах
    registrationSection.style.display = "block";
    chatSection.style.display = "none";
  } else {
    // Чат руу орох
    registrationSection.style.display = "none";
    chatSection.style.display = "block";
  }
});

// Бүртгэлийн форм илгээх
registrationForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  const name = registrationForm.name.value.trim();
  const gender = registrationForm.gender.value;
  const birthYear = registrationForm.birthYear.value;
  const zodiac = registrationForm.zodiac.value;
  const phone = registrationForm.phone.value.trim();
  const email = registrationForm.email.value.trim();
  const ageGroup = registrationForm.ageGroup.value;
  const password = registrationForm.password.value;

  if (!phone && !email) {
    registrationMessage.textContent = "Утас эсвэл имэйл заавал оруулах шаардлагатай.";
    return;
  }

  const regCode = "OS-" + Math.floor(100000 + Math.random() * 900000);

  const discount = ageGroup === "Дунд нас" ? "10%" : "";

  try {
    await db.collection("registrations").add({
      name, gender, birthYear, zodiac, phone, email, ageGroup, password, regCode, discount,
      timestamp: new Date(),
    });

    registrationMessage.textContent = `Амжилттай бүртгэгдлээ! Таны код: ${regCode}`;

    // Бүртгэл амжилттай болсон тул чат хэсэгт шилжүүлэх
    currentUserCode = regCode;
    registrationSection.style.display = "none";
    chatSection.style.display = "block";

  } catch (err) {
    registrationMessage.textContent = `Алдаа гарлаа: ${err.message}`;
  }
});

// Гарах товч дарвал
logoutBtn.addEventListener("click", () => {
  currentUserCode = null;
  chatSection.style.display = "none";
  registrationSection.style.display = "block";
  registrationMessage.textContent = "";
  registrationForm.reset();
});

// Чатын мессеж илгээх
sendBtn.addEventListener("click", () => {
  const message = chatInput.value.trim();
  if (!message) return;

  chatbox.innerHTML += `<div><b>Таны мессеж:</b> ${message}</div>`;
  chatInput.value = "";

  // Энд ChatGPT эсвэл таны chatbot API холболтыг нэмнэ
  // Жишээ:
  // fetch("API_URL", { ... }).then( ... ).catch( ... );
});
