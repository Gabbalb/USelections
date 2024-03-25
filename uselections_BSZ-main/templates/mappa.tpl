<script src="https://www.amcharts.com/lib/3/ammap.js" type="text/javascript"></script>
<script src="https://www.amcharts.com/lib/3/maps/js/usaHigh.js" type="text/javascript"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js" type="text/javascript"></script>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=yes, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">


    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre.min.css">
    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre-exp.min.css">
    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre-icons.min.css">

    <link rel="icon" href="https://clipart-library.com/images/8i65pnkLT.jpg" type="image/x-icon">


    <title>Us Elections</title>

    <style>
        .center {
            display: flex;
            justify-content: center;
        }
        form{
            justify-content: normal;
        }
        .left {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            text-align: center;
            justify-content: center;
        }

        .right {
            width: 60%;
        }

        .info {
            padding: 20px;
            width: 600px;
        }
        img{
            width: auto;
            height: 400px;
        }
        html{
            font-family: "Cascadia Mono";
            justify-items: center;
            text-align: center;
            align-items: center;
            margin: 20px;
        }

        body {
            font-family: Arial, sans-serif;
            font-size: 16px;
            line-height: 1.5;
            margin: 0;
            padding: 0;
        }

        /* Responsive and fluid container */
        .container {
            width: 90%; /* 90% of the viewport width */
            max-width: 1200px; /* Maximum width of 1200px */
            margin: 0 auto; /* Center the container */
            padding: 20px;
            box-sizing: border-box; /* Include padding and border in element's total width and height */
        }

        /* Responsive typography */
        h1 {
            font-size: 2em; /* 2 times the default font size */
        }

        p {
            font-size: 1em; /* 1 times the default font size */
        }

        /* Responsive images */
        img {
            max-width: 100%; /* Image will not exceed its container width */
            height: auto; /* Maintain aspect ratio */
        }

        /* Example of a media query */
        @media screen and (max-width: 768px) {
            /* Adjust styles for screens up to 768px wide */
            h1 {
                font-size: 1.5em; /* Decrease font size for smaller screens */
            }
        }

    </style>
</head>
<body>


<div class="container">
    <div class="heading">
        <!-- title or banner here -->
    </div>
    <div class="center">
        <div class="left">

            <div id="mapdiv" style="width: 800px; height: 450px; margin-right: 20px">Contenuto mappa</div>


            <form method="get" action="index.php" class="form-inline">
                <label for="yearSelect" class="mr-2">Choose a year:</label>
                <select name="year" id="yearSelect" class="form-select mr-2">
                    <?php
        $currentYear = date("Y");
        $startYear = 1976;
        $yearSelected = isset($_GET['year']) ? $_GET['year'] : '';
        for ($year = $startYear; $year <= $currentYear - 4; $year += 4) {
            $selected = ($year == $yearSelected) ? "selected" : "";
            echo "<option value=\"$year\" $selected>$year</option>";
                    }
                    ?>
                </select>
                <input type="submit" value="Submit" class="btn btn-primary">
            </form>


        </div>


        <div class="right">

            <h2>PERCENTAGE</h2>

            <table style="text-align: center; width: 900px; margin-left: 20px" class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Party</th>
                    <th>Percentage of Votes</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($vote_party as $one) : ?>
                <tr>
                    <td><strong><?php echo $one['party_simplified']; ?></strong></td>
                    <td><?php echo $one['percentuale_voti']; ?>%</td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>

        </div>

    </div>


    <div class="center">

        <div class="left">
            <div class="info">
                <h2>President: <?php echo $pres_and_vote[0]["candidate"]; ?></h2>
            </div>
            <img src="<?php echo $imageUrl; ?>" class="centered-image">
        </div>



        <div class="right">

            <table style="text-align: center; width: 600px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>
                <?php foreach ($pres_and_vote as $riga) : ?>
                <tr class="active">
                    <th><?php echo $riga['candidate']; ?></th>
                    <th><?php echo $riga['VOTI']; ?></th>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>
    </div>



    <br>
    <br>






    <form method="post">

        <select class="select select-primary form-select mr-2" name="state">
            <option disabled selected>Select a state</option>
            <option>All states</option>
            <?php foreach ($list_of_states as $state): ?>
            <option><?= $state["name"] ?></option>
            <?php endforeach; ?>
        </select>


        <input type="submit" value="Submit" class="btn btn-primary">


    </form>


    <!-- tabelle-->

    <!-- funzionamento: if l'utente clicca su uno stato specifico, mostra i candidati e i voti,
            else l'opzione scelta è "All states" mostra le mille tabelle
      else mostra le mille tabelle di default-->

    <?php if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['state'])): ?>
    <?php
        $selected_state = $_POST['state'];

        if ($selected_state !== "All states"):
            ?>
    <div style="flex: 1;">
        <h4> <strong>Filtred state: <?= $one_state_and_vote[0]["state"] ?> </strong></h4>
        <h4> <strong>Total votes: <?= $one_state_and_vote[0]["totalvotes"] ?> </strong></h4>
        <br>
        <table style="text-align: center; width: 900px; margin-left: 20px" class="table table-striped table-hover">
            <tr>
                <th> <strong> CANDIDATE </strong></th>
                <th> <strong> VOTE </strong> </th>
                <th> <strong> PARTY SIMPLIFIED </strong> </th>
                <th> <strong> PARTY DETAILED </strong> </th>
            </tr>
            <?php foreach ($one_state_and_vote as $state) : ?>
            <tr class="active">
                <td><?php echo $state['candidate']; ?></td>
                <td><?php echo $state['VOTI']; ?></td>
                <td><?php echo $state['party_simplified']; ?></td>
                <td><?php echo $state['party_detailed']; ?></td>

            </tr>
            <?php endforeach; ?>
        </table>
        <br>
    </div>
    <?php else: ?>
    <div style="display: flex; justify-content: space-between;">
        <div style="flex: 1;">
            <?php for ($k = 0; $k < 17; $k++) : ?>
            <table style="text-align: center; width: 400px; margin-left: 20px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 17; $k < 34; $k++) : ?>
            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 34; $k < 50; $k++) : ?>
            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
    </div>
    <?php endif; ?>

    <?php else: ?>
    <div style="display: flex; justify-content: space-between;">
        <div style="flex: 1;">
            <?php for ($k = 0; $k < 17; $k++) : ?>
            <table style="text-align: center; width: 400px; margin-left: 20px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 17; $k < 34; $k++) : ?>
            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 34; $k < 50; $k++) : ?>
            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> STATE </strong></th>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['state']; ?></td>
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
    </div>
    <?php endif; ?>

</div>
</body>
</html>



<script type="text/javascript">
    var mapData = null;

    fetch('states.json')
        .then(response => response.json())
        .then(data => {
            mapData = data;
            createMap();
        })
        .catch(error => {
            console.error('Error loading map data:', error);
        });

    function createMap() {
        if (mapData) {
            var map = AmCharts.makeChart("mapdiv", mapData);
        }
    }

    function blue_or_red() {

    }
</script>