function Bekuld(e) {
  e.preventDefault();
  alert("Beküldve");
}

// Available times for each service
const availableTimes = {
  service1: ["10:00 AM", "11:30 AM", "2:00 PM", "3:30 PM"],
  service2: ["9:00 AM", "12:00 PM", "1:00 PM", "4:00 PM"],
  service3: ["8:30 AM", "10:30 AM", "12:30 PM", "2:30 PM"],
  service4: ["8:30 AM", "10:30 AM", "12:30 PM", "2:30 PM"],
  service5: ["8:30 AM", "10:30 AM", "12:30 PM", "2:30 PM"],
  service3: ["8:30 AM", "10:30 AM", "12:30 PM", "2:30 PM"],
};

// Function to show available times when a service is selected
function showAvailableTimes() {
  const service = document.getElementById("service").value;
  const timeSlotsContainer = document.getElementById("timeSlots");
  const availableTimesDiv = document.getElementById("availableTimes");
  const submitBtn = document.getElementById("submitBtn");

  // Clear previous time slots
  timeSlotsContainer.innerHTML = "";
  submitBtn.disabled = false; // Enable submit button

  if (service && availableTimes[service]) {
    availableTimesDiv.style.display = "block"; // Show available times section
    availableTimes[service].forEach((time) => {
      // Create a radio button for each available time slot
      const radioButton = document.createElement("div");
      radioButton.innerHTML = `
                        <input type="radio" name="appointmentTime" value="${time}" required> 
                        <label>${time}</label><br>
                    `;
      timeSlotsContainer.appendChild(radioButton);
    });
  } else {
    availableTimesDiv.style.display = "none"; // Hide available times if no service is selected
  }
}

// Submit the booking form
function submitBooking(event) {
  event.preventDefault();

  const fullName = document.getElementById("fullName").value;
  const ssn = document.getElementById("ssn").value;
  const service = document.getElementById("service").value;
  const appointmentTime = document.querySelector(
    'input[name="appointmentTime"]:checked'
  )?.value;

  if (!appointmentTime) {
    alert("Please select an available time slot.");
    return;
  }

  // Display confirmation message
  alert(
    `Appointment booked successfully!\n\nDetails:\nName: ${fullName}\nSSN: ${ssn}\nService: ${service}\nTime: ${appointmentTime}`
  );
  // Reset form
  document.getElementById("bookingForm").reset();
  document.getElementById("availableTimes").style.display = "none";
  document.getElementById("submitBtn").disabled = true;
}
