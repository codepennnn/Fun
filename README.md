document.addEventListener("DOMContentLoaded", function () {
    // Get elements safely
    var hiddenField1 = document.getElementById('<%= HiddenChartData1.ClientID %>');
    var hiddenField2 = document.getElementById('<%= HiddenDonutChartData2.ClientID %>');
    var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>');
    var hoverchart = document.getElementById('<%= HiddenChartDaysCount.ClientID %>');
    
    if (!hiddenField1 || !hoverchart) {
        console.error('Hidden fields not found in the DOM.');
        return;
    }

    var chartData1 = hiddenField1.value.split(',').map(Number);
    var hover = hoverchart.value.split(',');
    
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

    var pieCtx1 = document.getElementById('pieChart1');
    if (pieCtx1) {
        var pieChart1 = new Chart(pieCtx1.getContext('2d'), {
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
                                let dataset = tooltipItem.dataset.data;
                                let h = tooltipItem.dataset.hh;
                                let value = dataset[tooltipItem.dataIndex] + " " + h;
                                return value;
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
            },
            plugins: [ChartDataLabels]
        });
    }

    // Doughnut Chart - Defensive Fix
    if (hiddenField2) {
        var chartData2 = hiddenField2.value.split(',').map(Number);
        var labels = ['Total','Pending With Vendor','Not Applicable','Complied','Save as Draft','Not Complied','Pending with Level 1 & Level 2'];
        var colors = ['#f9b037', '#5a7bf9', '#f95aa4', '#f99f5a', '#f95a5a', '#2d9646', '#3a376e'];

        var filteredData = chartData2.filter(v => v !== 0);
        var filteredLabels = labels.filter((_, i) => chartData2[i] !== 0);
        var filteredColors = colors.filter((_, i) => chartData2[i] !== 0);

        var pieCtx2 = document.getElementById('DoughnutChart');
        if (pieCtx2) {
            new Chart(pieCtx2.getContext('2d'), {
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
                },
                plugins: [ChartDataLabels]
            });
        }
    }

    // Button click event fix
    var btnSearch = document.getElementById("btnSearch");
    if (btnSearch) {
        btnSearch.addEventListener("click", function () {
            if (hiddenField3) {
                var dataPoints;
                try {
                    dataPoints = JSON.parse(hiddenField3.value);
                } catch (error) {
                    console.error("Invalid JSON Data:", error);
                    return;
                }

                if (dataPoints) {
                    console.log("Data Loaded", dataPoints);
                }
            }
        });
    }
});
