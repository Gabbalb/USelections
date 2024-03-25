
<?php

require 'vendor/autoload.php';
require 'Model/USERepository.php';

$templates = new League\Plates\Engine('templates', 'tpl');
$year = '1976';

if(isset($_GET['year'])) {

    $year = $_GET['year'];

    $el_primo = Model\StudenteRepository::getElectionResults($year);

    $jsonContents = file_get_contents('states.json');
    $jsonArray = json_decode($jsonContents, true);

    foreach ($jsonArray['dataProvider']['areas'] as &$area) {
        $state_po = substr($area['id'], 3);
        foreach ($el_primo as $result) {
            if ($result[0] === $state_po) {
                if ($result[1] == 'REPUBLICAN') {
                    $area['showAsSelected'] = true;
                } else {
                    $area['showAsSelected'] = false;
                }
            }
        }
        unset($area);
    }
    $updatedJsonContents = json_encode($jsonArray, JSON_PRETTY_PRINT);

    file_put_contents('states.json', $updatedJsonContents);
}


$one_state_and_vote = null;
$filtred_state = null;
if(isset($_POST['state'])) {
    $filtred_state = $_POST['state'];
    $one_state_and_vote = \Model\StudenteRepository::getOneStateInfo_on_year($year, $_POST['state']);
}


$pres_and_vote = Model\StudenteRepository::getUsPresident($year);
$states_info = Model\StudenteRepository::getAllStatesInfo($year);
$list_of_states = Model\StudenteRepository::getNameState();
$vote_party = Model\StudenteRepository::getVote_Party_on_year($year);



function getPresidentImage($name) {
    $url = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&pithumbsize=300&titles=" . urlencode($name);
    $response = file_get_contents($url);
    $data = json_decode($response, true);
    if (isset($data['query']['pages'])) {
        $page = current($data['query']['pages']);
        if (isset($page['thumbnail']['source'])) {
            return $page['thumbnail']['source'];
        }
    }
    return null;
}

$name_format = [
    "BUSH, GEORGE H.W." => "George Bush",
    "CARTER, JIMMY" => "Jimmy Carter",
    "REAGAN, RONALD" => "Ronald Reagan",
    "CLINTON, BILL" => "Bill Clinton",
    "GORE, AL" => "Al Gore",
    "OBAMA, BARACK H." => "Barack Obama",
    "CLINTON, HILLARY" => "Hillary Clinton",
    "BIDEN, JOSEPH R. JR" => "Joe Biden"
];


if ($pres_and_vote[0]["candidate"] == "BUSH, GEORGE H.W.") {
    $imageUrl = "https://www.whitehouse.gov/wp-content/uploads/2021/01/43_george_w_bush.jpg";
}else {
    $imageUrl = getPresidentImage($name_format[$pres_and_vote[0]["candidate"]]);
}

//Dear programmer
//When i wrote this code, only god and i knew how worked
//now, only Allah knows it
echo $templates->render('mappa', [
    'pres_and_vote' => $pres_and_vote,
    'state_info' => $states_info,
    'imageUrl' => $imageUrl,
    'year' => $year,
    'list_of_states' => $list_of_states,
    'one_state_and_vote' => $one_state_and_vote,
    'filtred_state' => $filtred_state,
    'vote_party' => $vote_party
]);
