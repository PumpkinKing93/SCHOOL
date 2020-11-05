
// creation of an object in javascript
var student = { "name":"Miguel", "age":22, "city":"Fresno" };

// It is possible to access the different elements the following way:

// returns Miguel
var student_name=student.name;
// returns Miguel
var student_name=student["name"];

// It is possible to modify the different elements the following way:
student.name="Carlos";
student["name"]="Carlos";

function DisplayMyNames() {
var myObj = { "name":"Jesus", "age":33, "horse":null };
for (x in myObj) {
    document.getElementById("demo").innerHTML += x + "<br>";
}
}

function DisplayMyValues() {
var myObj = { "name":"Jesus", "age":33, "horse":null };
for (x in myObj) {
    document.getElementById("demo").innerHTML += myObj[x] + "<br>";
}
}

let myPlayer = {
    "firstname":"Chris",
	"lastname":"Paul",
	"nickname":"CP3",
    "age":34,
	"ring":0,
    "team": {
        "team1":"Hornets",
        "team2":"Clippers",
        "team3":"Rockets",
		"team4":"Thunder",
    }
 };
 
function MyExample() {

// Parse example: JSON.parse
var myp = document.createElement('P'); 
document.body.appendChild(myp);
myp.innerHTML='<p id="demo1"></p>';
var obj1 = JSON.parse('{ "name":"Alfredo", "age":21, "city":"Madera"}');
document.getElementById("demo1").innerHTML = obj1.name + ", " + obj1.age + " living in " + obj1.city;

// Stringify example: JSON.stringify
var myp = document.createElement('P'); 
document.body.appendChild(myp);
myp.innerHTML='<p id="demo2"></p>';
var obj2 = { "name":"Rodrigo", "age":24, "city":"Hanford"};
var myJSON = JSON.stringify(obj2);
document.getElementById("demo2").innerHTML = myJSON;

}


