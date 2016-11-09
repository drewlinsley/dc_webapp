  function displayLineChart(ctx) {
    var data = {
        labels: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        datasets: [
            {
                label: "Prime and Fibonacci",
                fillColor: "rgba(220,220,220,0.2)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
            },
            {
                label: "My Second dataset",
                fillColor: "rgba(151,187,205,0.2)",
                strokeColor: "rgba(151,187,205,1)",
                pointColor: "rgba(151,187,205,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(151,187,205,1)",
                data: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
            }
        ]
    };
    var ctx = document.getElementById("lineChart").getContext("2d");
    var options = { };
    var myChart = new Chart(ctx).Line(data, options);
    return myChart
  }

function get_cnn_accuracies(clicks){
    var data = {};
    data.clicks = clicks;
    data.image_id = global_label;
    data.score = click_count;
    $.ajax({
        type: 'POST',
        url: '/clicks',
        data: data,
        dataType: 'application/json',
        success: function(data) {
            console.log('uploaded click. update a status bar now');
        }
    });
}

function getImage(ctx){
    var jqxhr = $.get('/cnn_accuracies', function () {
            })
    .done(function(data) {
        console.log(data);
      return;
    })
}

function update_chart(myChart,clicks_to_epoch,click_goal){
    myChart.data.datasets[0].data[0] = clicks_to_epoch;
    myChart.data.datasets[0].data[1] = click_goal;
    myChart.update();
}

var ctx = document.getElementById("myChart");
var myChart = displayLineChart(ctx); 
