var data;
var average;
var median;
var standardDeviation;
var min;
var max;

function getData(array) {
    var dataHTTP = new XMLHttpRequest();
    dataHTTP.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            data = JSON.parse(this.responseText)
            average = data['average'];
            console.log("Average: ", average);
            median = data['median'];
            console.log("Median: ", median);
            standardDeviation = data['standard_deviation'];
            console.log("Standard Deviation: ", standardDeviation);
            min = data['min'];
            console.log("Min: ", min);
            max = data['max'];
            console.log("Max: ", max);
        }
    };

    dataHTTP.open("GET", 'get.php?ar=' + JSON.stringify(array), true);
    dataHTTP.send();
}

function postData(array) {
    var dataHTTP = new XMLHttpRequest();
    dataHTTP.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            data = JSON.parse(this.responseText)
            average = data['average'];
            console.log("Average: ", average);
            median = data['median'];
            console.log("Median: ", median);
            standardDeviation = data['standard_deviation'];
            console.log("Standard Deviation: ", standardDeviation);
            min = data['min'];
            console.log("Min: ", min);
            max = data['max'];
            console.log("Max: ", max);
        }
    };

    dataHTTP.open("POST", 'post.php');
    dataHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    dataHTTP.send('ar=' + JSON.stringify(array));
    // alert(array);

}