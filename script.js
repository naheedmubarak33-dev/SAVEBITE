// NAVBAR ACTIVE LINK
const sections = document.querySelectorAll("section");
const navLinks = document.querySelectorAll(".navbar a");

window.addEventListener("scroll", () => {
let current = "";

sections.forEach(section => {
const sectionTop = section.offsetTop - 100;

if(window.scrollY >= sectionTop){
current = section.getAttribute("id");
}
});

navLinks.forEach(link => {
link.classList.remove("active");

if(link.getAttribute("href") === "#" + current){
link.classList.add("active");
}
});
});


// SMOOTH SCROLL FIXED
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
anchor.addEventListener("click", function(e) {

const target = document.querySelector(this.getAttribute("href"));

if(target){
e.preventDefault();
target.scrollIntoView({
behavior: "smooth"
});
}

});
});


// FADE ANIMATION
const fadeElements = document.querySelectorAll(".fade-in");

window.addEventListener("scroll", () => {
fadeElements.forEach(el => {
const position = el.getBoundingClientRect().top;
const screenHeight = window.innerHeight;

if(position < screenHeight - 100){
el.classList.add("show");
}
});
});


// COUNTER FIX
const counters = document.querySelectorAll(".stat-card h3");

let started = false;

window.addEventListener("scroll", () => {

const section = document.querySelector(".stats-section");

if(section){

const sectionTop = section.offsetTop - 200;

if(window.scrollY >= sectionTop && !started){

counters.forEach(counter => {

if(counter.hasAttribute("data-target")){

const target = +counter.getAttribute("data-target");
let count = 0;

const updateCounter = () => {

const increment = target / 100;

if(count < target){
count += increment;
counter.innerText = Math.ceil(count);
setTimeout(updateCounter, 20);
} else {
counter.innerText = target + "+";
}

};

updateCounter();

}

});

started = true;

}

}

});
const text = "Save Food, Share Hope";
let index = 0;

function typeEffect(){
if(index < text.length){
document.getElementById("typing-text").innerHTML += text.charAt(index);
index++;
setTimeout(typeEffect, 80);
}
}

typeEffect();
function showPage(pageId){

// sab pages hide karo
document.querySelectorAll(".page").forEach(page => {
page.style.display = "none";
});

// selected page show karo
document.getElementById(pageId).style.display = "block"

}
