<script type="text/javascript">
    Chart.register(ChartDataLabels);

    document.addEventListener("DOMContentLoaded", function () {

        // Pie Chart 1
        var hiddenField1 = document.getElementById('<%= HiddenChartData1.ClientID %>').value;
        var chartData1 = hiddenField1.split(',').map(Number); // Convert string to array of numbers

        var hoverChart = document.getElementById('<%= HiddenChartDaysCount.ClientID %>').value;
        var hover = hoverChart.split(',');

        var labels1 = ['Level1', 'Level2'];
        var colors1 = ['#f9b037', '#5a7bf9'];

        var filteredData1 = [];
        var filteredLabels1 = [];
        var filteredColors1 = [];
        var filteredHover1 = [];

        for (var i = 0; i < chartData1.length; i++) {
            if (chartData1[i] !== 0) {
                filteredData1.push(chartData1[i]);
                filteredLabels1.push(labels1[i]);
                filteredColors1.push(colors1[i]);
                filteredHover1.push(hover[i]);
            }
        }

        var pieCtx1 = document.getElementById('pieChart1').getContext('2d');
        var pieChart1 = new Chart(pieCtx1, {
            type: 'pie',
            data: {
                labels: filteredLabels1,
                datasets: [{
                    data: filteredData1,
                    backgroundColor: filteredColors1,
                    borderColor: filteredColors1,
                    borderWidth: 1,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: 10
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: {
                            boxWidth: 12,
                            padding: 9
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                let index = tooltipItem.dataIndex;
                                return `${filteredData1[index]} (${filteredHover1[index]})`;
                            }
                        }
                    },
                    datalabels: {
                        formatter: (value, ctx) => {
                            let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                            let percentage = ((value / sum) * 100).toFixed(1) + "%";
                            return percentage;
                        },
                        color: '#000',
                        font: {
                            weight: 'bold'
                        }
                    }
                }
            }
        });

        // Doughnut Chart
        var hiddenField2 = document.getElementById('<%= HiddenDonutChartData2.ClientID %>').value;
        var chartData2 = hiddenField2.split(',').map(Number);

        var labels2 = [
            'Total', 'Pending With Vendor', 'Not Applicable',
            'Complied', 'Save as Draft', 'Not Complied', 'Pending with Level 1 & Level 2'
        ];
        var colors2 = ['#f9b037', '#5a7bf9', '#f95aa4', '#f99f5a', '#f95a5a', '#2d9646', '#3a376e'];

        var filteredData2 = [];
        var filteredLabels2 = [];
        var filteredColors2 = [];

        for (var i = 0; i < chartData2.length; i++) {
            if (chartData2[i] !== 0) {
                filteredData2.push(chartData2[i]);
                filteredLabels2.push(labels2[i]);
                filteredColors2.push(colors2[i]);
            }
        }

        var pieCtx2 = document.getElementById('DoughnutChart').getContext('2d');
        var pieChart2 = new Chart(pieCtx2, {
            type: 'doughnut',
            data: {
                labels: filteredLabels2,
                datasets: [{
                    data: filteredData2,
                    backgroundColor: filteredColors2,
                    borderColor: filteredColors2,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: 20
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'right',
                        labels: {
                            boxWidth: 12,
                            padding: 9
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                let index = tooltipItem.dataIndex;
                                return `${filteredData2[index]}`;
                            }
                        }
                    },
                    datalabels: {
                        formatter: (value, ctx) => {
                            let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                            let percentage = ((value / sum) * 100).toFixed(1) + "%";
                            return percentage;
                        },
                        color: '#000',
                        font: {
                            weight: 'bold'
                        }
                    }
                }
            }
        });

        // Dual Line Chart
        window.onload = function () {
            var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
            var dataPoints = JSON.parse(hiddenField3);

            var labels3 = dataPoints.map(dp => `${dp.month}/${dp.year}`);
            var l1Data = dataPoints.map(dp => dp.L1);
            var l2Data = dataPoints.map(dp => dp.L2);

            var ctx = document.getElementById('DualLineChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels3,
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
                            data: Array(labels3.length).fill(3),
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
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: { stepSize: 1 }
                        }
                    },
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
                    }
                }
            });
        };
    });
</script>
