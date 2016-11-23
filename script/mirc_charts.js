var ctx = document.getElementById("myChart");
myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: ["Progress"], //"Number of clicks recorded", "Clicks until next epoch of training"
        datasets: [{
            data: [5000],
            label: "Image realization maps provided by users",
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1},{
            data: [20000],
            label: "Maps needed until next epoch of model training",
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1}]
    },
    options: {
        responsive: false,
    scales: {
        xAxes: [{
            ticks: {
                beginAtZero:true,
                fontFamily: "'Open Sans Bold', sans-serif",
                fontSize:11
            },
            scaleLabel:{
                display:false
            },
            gridLines: {
            }, 
            stacked: true
        }],
        yAxes: [{
            gridLines: {
                display:false,
                color: "#fff",
                zeroLineColor: "#fff",
                zeroLineWidth: 0
            },
            ticks: {
                fontFamily: "'Open Sans Bold', sans-serif",
                color: "#fff",
                minRotation: 90, // angle in degrees
                labelOffset: -20
            },
            stacked: true
        }]
    },
    legend:{
        display:false
    }
    }
});

function update_chart(myChart,clicks_to_epoch,click_goal){
	myChart.data.datasets[0].data[0] = clicks_to_epoch;
	myChart.data.datasets[0].data[1] = click_goal;
	myChart.update();
}

