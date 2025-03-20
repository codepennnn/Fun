window.onload = function () {
    try {
        var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
        alert("HiddenField3 value: " + hiddenField3);

        // Fix JSON format by replacing single quotes or unquoted keys if necessary
        var formattedData = hiddenField3
            .replace(/([{,]\s*)([A-Za-z0-9_]+)(\s*:)/g, '$1"$2"$3') // Fix missing quotes around keys
            .replace(/(['"])?([a-zA-Z0-9_]+)(['"])?:/g, '"$2":')     // Fix any missing double quotes
            .replace(/'/g, '"');                                     // Replace single quotes with double quotes

        var dataPoints = JSON.parse(formattedData);
        alert("Parsed data: " + JSON.stringify(dataPoints));

        var labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
        var l1Data = dataPoints.map(dp => dp.l1);
        var l2Data = dataPoints.map(dp => dp.l2);

        var ctx = document.getElementById('DualLineChart').getContext('2d');
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
                plugins: {
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
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            },
            plugins: [ChartDataLabels]
        });

    } catch (error) {
        alert("Error parsing data: " + error.message);
    }
};
