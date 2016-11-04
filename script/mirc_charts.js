var ctx = document.getElementById("myChart");
myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: ["Number of clicks recorded", "Clicks until next epoch of training"],
        datasets: [{
            label: '# of Votes',
            data: [5000, 20000],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1
        }]
    },
    options: {
        rotation: 1 * Math.PI,
        circumference: 1 * Math.PI,
        responsive: false
    }
});

function update_chart(myChart,clicks_to_epoch,click_goal){
	myChart.data.datasets[0].data[0] = clicks_to_epoch;
	myChart.data.datasets[0].data[1] = click_goal;
	myChart.update();
}

