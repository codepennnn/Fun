Uncaught TypeError: Cannot read properties of null (reading 'value')
    at HTMLDocument.<anonymous> (Wage_Dash_1.aspx:479:92)Understand this errorAI
Wage_Dash_1.aspx:560 Uncaught TypeError: Cannot read properties of null (reading 'addEventListener')
    at HTMLDocument.<anonymous> (Wage_Dash_1.aspx:560:49)

     <script type="text/javascript">


        Chart.register(ChartDataLabels);
        document.addEventListener("DOMContentLoaded", function ()
        {
            var hiddenField1 = document.getElementById('<%= HiddenChartData1.ClientID %>').value;
            var chartData1 = hiddenField1.split(',').map(Number); // Convert string to array of numbers

            var hoverchart = document.getElementById('<%= HiddenChartDaysCount.ClientID %>').value;          
           
            var labels = ['Level1', 'Level2'];
            var filteredData = [];
            var filteredLabels = [];
            var filteredColors = [];
            var filteredhover = [];
            var hover = hoverchart.split(',');
            var colors = ['#f9b037', '#5a7bf9'];

            for (var i = 0; i < chartData1.length; i++)
            {
              if (chartData1[i] !== 0) {
                filteredData.push(chartData1[i]);
                filteredLabels.push(labels[i]);
                  filteredColors.push(colors[i]);
                  filteredhover.push(hover[i]);
                  
              }
            }

            var pieCtx1 = document.getElementById('pieChart1').getContext('2d');
            var pieChart1 = new Chart(pieCtx1, {
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
                              
                                let value = dataset[tooltipItem.dataIndex]+" "+h;
                                
                                return value; // Show number on hover
                            }
                        }
                    },
                    datalabels: {
                        formatter: (value, ctx) => {
                            let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                            let percentage = ((value / sum) * 100).toFixed(1) + "%";
                            return percentage; // Show percentage inside the pie chart
                        },
                        color: '#000',
                        font: {
                            weight: 'bold'
                        }
                    }
                }
            },
                plugins: [ChartDataLabels] // Make sure to include ChartDataLabels

            });




            /*DoughnutChart*/



            var hiddenField2 = document.getElementById('<%= HiddenDonutChartData2.ClientID %>').value;
            var chartData2 = hiddenField2.split(',').map(Number); // Convert string to array of numbers
            var labels = ['Total','Pending With Vendor','Not Applicable','Complied','Save as Draft','Not Complied','Pending with Level 1 & Level 2'];
            var filteredData = [];
            var filteredLabels = [];
            var filteredColors = [];
            var colors = ['#f9b037', '#5a7bf9', '#f95aa4', '#f99f5a', '#f95a5a', '#2d9646','#3a376e'];

            for (var i = 0; i < chartData2.length; i++) {
                if (chartData2[i] !== 0) {
                    filteredData.push(chartData2[i]);
                    filteredLabels.push(labels[i]);
                    filteredColors.push(colors[i]);
                }
            }



            var pieCtx2 = document.getElementById('DoughnutChart').getContext('2d');
            var pieChart2 = new Chart(pieCtx2, {
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
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    let dataset = tooltipItem.dataset.data;
                                    let value = dataset[tooltipItem.dataIndex];
                                    return value; // Show number on hover
                                }
                            }
                        },
                        datalabels: {
                            formatter: (value, ctx) => {
                                let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                                let percentage = ((value / sum) * 100).toFixed(1) + "%";
                                return percentage; // Show percentage inside the pie chart
                            },
                            color: '#000',
                            font: {
                                weight: 'bold'
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels] // Make sure to include ChartDataLabels
            });


            /*DualLineChart*/

            



     
        });

        document.addEventListener("DOMContentLoaded", () => {
            document.getElementById("btnSearch").addEventListener("click", function () {
                var hiddenField3 = document.getElementById('<%= HiddenField3.ClientID %>').value;
        alert(hiddenField3);

        if (!hiddenField3) {
            console.log("No Data");
            return;
        }

        var dataPoints;
        try {
            dataPoints = JSON.parse(hiddenField3); // Ensure JSON parsing
        } catch (error) {
            console.error("Invalid JSON Data:", error);
            return;
        }

        const labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
        const l1Data = dataPoints.map(dp => dp.l1);
        const l2Data = dataPoints.map(dp => dp.l2);

        const ctx = document.getElementById('DualLineChart').getContext('2d');

        Chart.register(ChartDataLabels); // Register the plugin

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
            }
        });
    });
        });


      

   



        
    </script>
