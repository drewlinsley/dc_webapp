var ctx = document.getElementById("myChart");
myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: ["Progress"], //"Number of clicks recorded", "Clicks until next epoch of training"
        datasets: [{
            data: [5000],
            label: "Image realization maps provided by users",
            backgroundColor: [
                'rgba(247,247,247, 0.2)',
            ],
            borderColor: [
                'rgba(247,247,247,1)',
            ],
            borderWidth: 1},{
            data: [20000],
            label: "Maps needed until next epoch of model training",
            backgroundColor: [
                'rgba(18,22,23, 0.2)',
            ],
            borderColor: [
                'rgba(18,22,23, 1)',
            ],
            borderWidth: 1}]
    },
    options: {
        responsive: false,
        tooltips: {
            bodyFontSize:8,
            titleFontSize:0,
            titleMarginBottom:0,
            titleSpacing:0
        },
    scales: {
        xAxes: [{
            ticks: {
                beginAtZero:true,
                fontFamily: "'Open Sans Bold', sans-serif",
                fontSize:11,
		fontColor:"black",
                max: 20000
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
                zeroLineColor: "#fff",
                zeroLineWidth: 0
            },
            ticks: {
                fontFamily: "'Open Sans Bold', sans-serif",
                fontColor: "black",
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

/*
var ctx = document.getElementById("ppChart");
ppChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: ["AI score"], //"Number of clicks recorded", "Clicks until next epoch of training"
        datasets: [{
            data: [0],
            label: "Correct answer confidence",
            backgroundColor: [
                'rgba(31, 207, 34, 0.2)',
            ],
            borderColor: [
                'rgba(31, 207, 34,1)',
            ],
            borderWidth: 1},{
            data: [0],
            label: "Incorrect answer confidence",
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1}]
    },
    options: {
        responsive: false,
        tooltips: {
            bodyFontSize:8,
            titleFontSize:0,
            titleMarginBottom:0,
            titleSpacing:0
        },
    scales: {
        xAxes: [{
            ticks: {
                beginAtZero:true,
                fontFamily: "'Open Sans Bold', sans-serif",
                fontSize:11,
                fontColor:"black",
                max: 100
            },
            scaleLabel:{
                display:false
            },
            gridLines: {
            },
        }],
        yAxes: [{
            gridLines: {
                display:false,
                zeroLineColor: "#fff",
                zeroLineWidth: 0
            },
            ticks: {
                fontFamily: "'Open Sans Bold', sans-serif",
                fontColor: "black",
                minRotation: 90, // angle in degrees
                labelOffset: -20
            },
        }]
    },
    legend:{
        display:false
    }
    }
});

function update_pps(ppChart,in_pp,out_pp){
	ppChart.data.datasets[0].data[0] = in_pp;
        ppChart.data.datasets[1].data[0] = out_pp;
        ppChart.update();
}

*/
