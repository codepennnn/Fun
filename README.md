document.addEventListener("DOMContentLoaded", function () {
    Chart.register(ChartDataLabels);

    // ===== PIE CHART =====
    var hiddenField1 = document.getElementById('<%= HiddenChartData1.ClientID %>');
    var hoverchart = document.getElementById('<%= HiddenChartDaysCount.ClientID %>');

    if (hiddenField1 && hoverchart) {
        try {
            var chartData1 = hiddenField1.value.split(',').map(Number);
            var hover = hoverchart.value.split(',');

            var labels = ['Level1', 'Level2'];
            var colors = ['#f9b037', '#5a7bf9'];
            var filteredData = [];
            var filteredLabels = [];
            var filteredColors = [];
            var filteredHover = [];

            for (var i = 0; i < chartData1.length; i++) {
                if (chartData1[i] !== 0) {
                    filteredData.push(chartData1[i]);
                    filteredLabels.push(labels[i]);
                    filteredColors.push(colors[i]);
                    filteredHover.push(hover[i]);
                }
            }

            var pieCtx1 = document.getElementById('pieChart1');
            if (pieCtx1) {
                new Chart(pieCtx1.getContext('2d'), {
                    type: 'pie',
                    data: {
                        labels: filteredLabels,
                        datasets: [{
                            data: filteredData,
                            backgroundColor: filteredColors,
                            borderColor: filteredColors,
                            borderWidth: 1,
                            hoverOffset: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'bottom'
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (tooltipItem) {
                                        let value = tooltipItem.raw;
                                        let hoverValue = filteredHover[tooltipItem.dataIndex];
                                        return value + " (" + hoverValue + ")";
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
            }
        } catch (error) {
            console.error("Error processing pie chart data:", error);
        }
    } else {
        console.error("Pie chart hidden fields not found.");
    }

    // ===== DOUGHNUT CHART =====
    var hiddenField2 = document.getElementById('<%= HiddenDonutChartData2.ClientID %>');
    if (hiddenField2) {
        try {
            var chartData2 = hiddenField2.value.split(',').map(Number);
            var labels = ['Total', 'Pending With Vendor', 'Not Applicable', 'Complied', 'Save as Draft', 'Not Complied', 'Pending with Level 1 & Level 2'];
            var colors = ['#f9b037', '#5a7bf9', '#f95aa4', '#f99f5a', '#f95a5a', '#2d9646', '#3a376e'];

            var filteredData = chartData2.filter(v => v !== 0);
            var filteredLabels = labels.filter((_, i) => chartData2[i] !== 0);
            var filteredColors = colors.filter((_, i) => chartData2[i] !== 0);

            var doughnutCtx = document.getElementById('DoughnutChart');
            if (doughnutCtx) {
                new Chart(doughnutCtx.getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: filteredLabels,
                        datasets: [{
                            data: filteredData,
                            backgroundColor: filteredColors,
                            borderColor: filteredColors,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'right'
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
            }
        } catch (error) {
            console.error("Error processing doughnut chart data:", error);
        }
    } else {
        console.error("Doughnut chart hidden field not found.");
    }

    // ===== DUAL LINE CHART =====
    var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>');
    var btnSearch = document.getElementById("btnSearch");
    if (btnSearch) {
        btnSearch.addEventListener("click", function () {
            if (hiddenField3) {
                try {
                    var dataPoints = JSON.parse(hiddenField3.value);
                    var labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
                    var l1Data = dataPoints.map(dp => dp.l1);
                    var l2Data = dataPoints.map(dp => dp.l2);

                    var lineCtx = document.getElementById('DualLineChart');
                    if (lineCtx) {
                        new Chart(lineCtx.getContext('2d'), {
                            type: 'line',
                            data: {
                                labels: labels,
                                datasets: [
                                    {
                                        label: 'L1 Data',
                                        data: l1Data,
                                        borderColor: 'blue',
                                        fill: false
                                    },
                                    {
                                        label: 'L2 Data',
                                        data: l2Data,
                                        borderColor: 'green',
                                        fill: false
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                scales: {
                                    y: { beginAtZero: true }
                                }
                            }
                        });
                    }
                } catch (error) {
                    console.error("Invalid JSON data:", error);
                }
            } else {
                console.error("HiddenField3 is empty or not found.");
            }
        });
    }
});
