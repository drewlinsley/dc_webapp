  function displayLineChart(ctx) {
    var data = {
        labels: [1, 2],
        datasets: [
            {
                label: "Baseline VGG 16",
                borderColor: "#8c0002",
                pointBackgroundColor: "#8c0002",
                backgroundColor: "#8c0002",
                data: [2, 3]
            },
            {
                label: "CLICKTIONARY-modulated VGG 16",
                borderColor: "#478dff",
                pointBackgroundColor: "#478dff",
                backgroundColor: "#478dff",
                data: [0, 1]
            },
        ]
    };
    options = {
      scales: {

        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: 'Top-1 classification accuracy'
          }
        }],
        xAxes: [{
          scaleLabel: {
            display: true,
            labelString: 'Date of accuracy update'
          }
        }]
      },responsive: true
    }
    var myChart = new Chart(ctx, {type: "line", data: data, options});
    return myChart
  }

function get_cnn_accuracies(ctx){
    var jqxhr = $.get('/cnn_accuracies', function () {
            })
    .done(function(data) {
        me = data
        update_chart(JSON.parse(data));
      return;
    })
}

function update_chart(jd){
    var labels = [];
    var baseline_data = [];
    var attention_data = [];
    for (var i = 0; i < jd['attention'].length; i++){
        attention_data[i] = jd['attention'][i][0];
        baseline_data[i] = jd['baseline'][0];
        labels[i] = jd['attention'][i][1];
    }
    myChart.data.labels = labels;
    myChart.data.datasets[0].data = baseline_data;
    myChart.data.datasets[1].data = attention_data;
    myChart.update();
}
Chart.defaults.global.defaultFontColor = "#fff";

var ctx = document.getElementById("myChart");
var myChart = displayLineChart(ctx); 

get_cnn_accuracies(ctx);