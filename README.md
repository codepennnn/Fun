
        window.onload = function () {
            var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;

            //alert(hiddenField3)
            //var dataPoints = JSON.parse(hiddenField3);
            //var a = datapoint.map(dp => [dp.month, dp.year, dp.L1, dp.L2])

            var dataPoints = [
                { month: 4, year: 2023, l1: 3, l2: 5 },
                { month: 5, year: 2023, l1: 4, l2: 6 },
                { month: 6, year: 2023, l1: 5, l2: 7 },
                { month: 7, year: 2023, l1: 6, l2: 2 },
                { month: 8, year: 2023, l1: 5, l2: 3 },
                { month: 9, year: 2023, l1: 4, l2: 4 },
                { month: 10,year:2023,  l1: 3, l2: 5 },
                { month: 11,year:2023, l1: 2, l2: 6 },
                { month: 12,year:2023, l1: 5, l2: 4 },
                { month: 1, year: 2024, l1: 3, l2: 5 },
                { month: 2, year: 2024, l1: 4, l2: 6 },
                { month: 3, year: 2024, l1: 5, l2: 7 },
                { month: 4, year: 2024, l1: 6, l2: 2 },
                { month: 5, year: 2024, l1: 5, l2: 3 },
                { month: 6, year: 2024, l1: 4, l2: 4 },
                { month: 7, year: 2024, l1: 3, l2: 5 },
                { month: 8, year: 2024, l1: 2, l2: 6 },
                { month: 9, year: 2024, l1: 5, l2: 4 },
                { month: 10, year: 2024, l1: 3, l2: 5 },
                { month: 11, year: 2024, l1: 4, l2: 6 },
                { month: 12, year: 2024, l1: 5, l2: 7 },
            ];
            alert(dataPoints);
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
                            formatter: (value, context) => {
                                return value; // Show data labels for L1 and L2 lines
                            },
                            display: (context) => {
                                // Only show data labels for L1 and L2 datasets, not for the average line
                                return context.dataset.label !== 'Average (3)';
                            }
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
        }


dummy data working but dynamic not working while dynamic data are coming but not set in that pls solve this
