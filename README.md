<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>CLMS - Industrial Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Lottie for animation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.9.4/lottie.min.js"></script>

    <style>
        body {
            background-color: #f4f6f8;
            font-family: 'Segoe UI', sans-serif;
        }

        .dashboard-container {
            padding: 50px 20px 30px 20px;
        }

        .card-box {
            height: 140px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .card-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .card-link {
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
        }

        .bg-orange { background-color: #fd7e14; }
        .bg-purple { background-color: #6f42c1; }

        /* Animation section */
        .animation-container {
            margin-top: 50px;
            text-align: center;
        }

        #lottie-animation {
            width: 300px;
            height: 300px;
            margin: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container dashboard-container">
            <div class="row g-4 justify-content-center">

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-danger">
                        <a class="card-link" href="FNF_StartPage.aspx" target="_blank">Full & Final Excel Upload</a>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-primary">
                        <a class="card-link" href="Full_N_Final_Settlement.aspx" target="_blank">Full & Final Generation</a>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-success">
                        <a class="card-link" href="../Report/Annexure_of_FormG_Report.aspx" target="_blank">Annexure Form G Report</a>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-warning">
                        <a class="card-link" href="../Report/FORM_G_Confirmation_Report.aspx" target="_blank">Form G Download</a>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-orange">
                        <a class="card-link" href="FNF_FormG.aspx" target="_blank">Form G Upload</a>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-4">
                    <div class="card-box bg-purple">
                        <a class="card-link" href="../Report/FNF_Final_Report.aspx" target="_blank">Full & Final Report</a>
                    </div>
                </div>

            </div>

            <!-- Animation / Image Below -->
            <div class="animation-container">
                <div id="lottie-animation"></div>
                <p class="mt-3 text-muted">CLMS Portal - Manage your final settlements with ease</p>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Load animation -->
    <script>
        lottie.loadAnimation({
            container: document.getElementById('lottie-animation'),
            renderer: 'svg',
            loop: true,
            autoplay: true,
            path: 'https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json' // You can change this to any animation you like
        });
    </script>
</body>
</html>
