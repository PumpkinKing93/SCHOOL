//function that display value 
function dis(val) {
    document.getElementById("result").value += val
}

//function that evaluates the digit and return result 
function solve() {
    let x = document.getElementById("result").value
    let y = eval(x)
    document.getElementById("result").value = y
}

//function that clear the display 
function clr() {
    document.getElementById("result").value = ""
} 

// sqrt a number
function sqrt(){
    let x = document.getElementById("result").value
    let y = Math.sqrt(x)
    document.getElementById("result").value = y
}

//function that display value 
function neg() {
    let x = document.getElementById("result").value
    let y = eval(-1*x)
    document.getElementById("result").value = y
}