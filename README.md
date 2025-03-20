<script type="text/javascript">
    Chart.register(ChartDataLabels);

    document.addEventListener("DOMContentLoaded", function () {

        // ✅ Pie Chart
        var hiddenField1 = document.getElementById('HiddenChartData1');
        var hiddenFieldHover = document.getElementById('HiddenChartDaysCount');

        if (hiddenField1 && hiddenFieldHover) {
            var hiddenValue1 = hiddenField1.value;
            var hoverchart = hiddenFieldHover.value;

            alert("HiddenChartData1 value: " + hiddenValue1);
            alert("HiddenChartDaysCount value: " + hoverchart);

            var chartData1 = hiddenValue1.split(',').map(Number);
            var hover = hoverchart.split(',');

            var labels = ['Level1', 'Level2'];
            var colors = ['#f9b037', '#5a7bf9'];
            var filteredData = [];
            var filteredLabels = [];
            var filteredColors = [];
            var filteredhover = [];

            for (var i = 0; i < chartData1.length; i++) {
                if (chartData1[i] !== 0) {
                    filteredData.push(chartData1[i]);
                    filteredLabels.push(labels[i]);
                    filteredColors.push(colors[i]);
                    filteredhover.push(hover[i]);
                }
            }

            var pieCtx1 = document.getElementById('pieChart1').getContext('2d');
            new Chart(pieCtx1, {
                type: 'pie',
                data: {
                    labels: filteredLabels,
                    datasets: [{
                        data: filteredData,
                        backgroundColor: filteredColors,
                        borderColor: filteredColors,
                        borderWidth: 1,
                        hh: filteredhover
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: { padding: 10 },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'bottom',
                            labels: { boxWidth: 12, padding: 9 }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    let dataset = tooltipItem.dataset.data;
                                    let h = tooltipItem.dataset.hh;
                                    return dataset[tooltipItem.dataIndex] + " " + h;
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
                            font: { weight: 'bold' }
                        }
                    }
                }
            });
        } else {
            alert("HiddenChartData1 or HiddenChartDaysCount not found!");
        }

        // ✅ Doughnut Chart
        var hiddenField2 = document.getElementById('HiddenDonutChartData2');
        if (hiddenField2) {
            var hiddenValue2 = hiddenField2.value;
            alert("HiddenDonutChartData2 value: " + hiddenValue2);

            var chartData2 = hiddenValue2.split(',').map(Number);
            var labels = ['Total', 'Pending With Vendor', 'Not Applicable', 'Complied', 'Save as Draft', 'Not Complied', 'Pending with Level 1 & Level 2'];
            var colors = ['#f9b037', '#5a7bf9', '#f95aa4', '#f99f5a', '#f95a5a', '#2d9646', '#3a376e'];
            var filteredData = [];
            var filteredLabels = [];
            var filteredColors = [];

            for (var i = 0; i < chartData2.length; i++) {
                if (chartData2[i] !== 0) {
                    filteredData.push(chartData2[i]);
                    filteredLabels.push(labels[i]);
                    filteredColors.push(colors[i]);
                }
            }

            var pieCtx2 = document.getElementById('DoughnutChart').getContext('2d');
            new Chart(pieCtx2, {
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
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'right',
                            labels: { boxWidth: 12, padding: 9 }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    let dataset = tooltipItem.dataset.data;
                                    return dataset[tooltipItem.dataIndex];
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
                            font: { weight: 'bold' }
                        }
                    }
                }
            });
        } else {
            alert("HiddenDonutChartData2 not found!");
        }
    });

    window.onload = function () {
        var hiddenField3 = document.getElementById('HiddenField3');
        if (hiddenField3) {
            var dataPoints = JSON.parse(hiddenField3.value);
            alert("HiddenField3 value: " + JSON.stringify(dataPoints));

            var labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
            var l1Data = dataPoints.map(dp => dp.L1);
            var l2Data = dataPoints.map(dp => dp.L2);

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
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, ticks: { stepSize: 1 } }
                    }
                }
            });
        } else {
            alert("HiddenField3 not found!");
        }
    };
</script>

<!-- ✅ Correct Hidden Field Definitions -->
<asp:HiddenField ID="HiddenChartData1" runat="server" ClientIDMode="Static" />
<asp:HiddenField ID="HiddenChartDaysCount" runat="server" ClientIDMode="Static" />
<asp:HiddenField ID="HiddenDonutChartData2" runat="server" ClientIDMode="Static" />
<asp:HiddenField ID="HiddenField3" runat="server" ClientIDMode="Static" />
