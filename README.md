<script type="text/javascript">
    window.onload = function () {
        // ✅ Get dynamic data from HiddenField3
        var hiddenField3 = document.getElementById('HiddenField3');
        if (hiddenField3) {
            var hiddenValue = hiddenField3.value;
            alert("HiddenField3 value: " + hiddenValue);

            try {
                var dataPoints = JSON.parse(hiddenValue);
                alert("Parsed DataPoints: " + JSON.stringify(dataPoints));

                // ✅ Map dynamic data for the chart
                var labels = dataPoints.map(dp => `${dp.month}/${dp.year}`);
                var l1Data = dataPoints.map(dp => dp.L1); // Ensure the key names match dynamic data
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
            } catch (e) {
                console.error("Error parsing HiddenField3 value:", e);
                alert("Error parsing data: " + e.message);
            }
        } else {
            alert("HiddenField3 not found!");
        }
    };
</script>

<!-- ✅ Ensure ClientIDMode is set to Static -->
<asp:HiddenField ID="HiddenField3" runat="server" ClientIDMode="Static" />
<canvas id="DualLineChart"></canvas>
