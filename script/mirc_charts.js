var ctx = document.getElementById("myChart");
myChart = null;

function init_chart(clicks_total)
{
    return new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: ["Progress"], //"Number of clicks recorded", "Clicks until next epoch of training"
            datasets: [{
                data: [10],
                label: "Clicks until AI evolves",
                backgroundColor: [
                    'rgba(247,247,247, 0.2)',
                ],
                borderColor: [
                    'rgba(247,247,247,1)',
                ],
                borderWidth: 1},/*{
                data: [200],
                label: "Clicks until AI evolves",
                backgroundColor: [
                    'rgba(18,22,23, 0.2)',
                ],
                borderColor: [
                    'rgba(18,22,23, 1)',
                ],
                borderWidth: 1}*/]
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
                    max: clicks_total
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
}

myChart = init_chart(4011);

function update_chart(myChart,accum_clicks,clicks_to_go){
    /*if (myChart === null)
    {
        console.log(myChart);
        myChart = init_chart(accum_clicks + clicks_to_go);
        console.log(myChart);
    }*/
	myChart.data.datasets[0].data[0] = clicks_to_go;
	myChart.update();
	//myChart.data.datasets[0].data[1] = clicks_to_go;
	//myChart.scales.xAxes[0].ticks.max = accum_clicks + clicks_to_go;
	//myChart.update();
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
