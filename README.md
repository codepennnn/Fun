Chart.register(ChartDataLabels);

document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnSearch").addEventListener("click", function () {
        var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
        
        if (!hiddenField3) {
            console.log("No Data");
            return;
        }

        let dataPoints;
        try {
            dataPoints = JSON.parse(hiddenField3);
        } catch (error) {
            console.error("Invalid JSON Data:", error);
            return;
        }

        const labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
        const l1Data = dataPoints.map(dp => dp.l1);
        const l2Data = dataPoints.map(dp => dp.l2);

        const ctx = document.getElementById('DualLineChart').getContext('2d');
        if (!ctx) {
            console.error("DualLineChart element not found!");
            return;
        }

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'L1 Data',
                        data: l1Data,
                        borderColor: 'blue',
                        backgroundColor: 'blue',
                        fill: false,
                        tension: 0.3
                    },
                    {
                        label: 'L2 Data',
                        data: l2Data,
                        borderColor: 'green',
                        backgroundColor: 'green',
                        fill: false,
                        tension: 0.3
                    },
                    {
                        label: 'Average (3)',
                        data: Array(labels.length).fill(3),
                        borderColor: 'red',
                        borderWidth: 1,
                        borderDash: [5, 5],
                        pointRadius: 0,
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom'
                    },
                    datalabels: {
                        color: 'black',
                        anchor: 'end',
                        align: 'bottom',
                        font: {
                            weight: 'bold',
                            size: 10
                        },
                        formatter: (value) => value,
                        display: (context) => context.dataset.label !== 'Average (3)'
                    }
                }
            }
        });
    });
});
