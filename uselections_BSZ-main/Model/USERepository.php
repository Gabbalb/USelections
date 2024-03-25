<?php

namespace Model;
use Util\Connection;

require 'Util/Connection.php';

class StudenteRepository {
        public static function getElectionResults($year) {
        $pdo = Connection::getInstance();
        $sql = "SELECT po, party_detailed FROM
    (SELECT state.po, party_detailed
     FROM party INNER JOIN vote ON id_party = party.id
                INNER JOIN state ON id_state = state.id
                INNER JOIN election ON id_election = election.id
     WHERE YEAR = " . $year . " AND (party.party_detailed = 'DEMOCRAT' OR party.party_detailed = 'REPUBLICAN')) AS a
     GROUP BY po;";
        $results = $pdo -> query($sql);
        return $results -> fetchAll();

    }


    public static function getUsPresident($year) {
        $pdo = Connection::getInstance();
        $sql = "SELECT candidate, SUM(candidatevotes) as VOTI
                FROM election_data
                WHERE year = :year
                GROUP BY candidate
                ORDER BY VOTI DESC
                LIMIT 0, 5
                ";
        $result = $pdo->prepare($sql);
        $result->execute([
            'year' => $year
        ]);
        return $result->fetchAll();
    }


    public static function getAllStatesInfo($year) {
        $pdo = Connection::getInstance();
        $sql = "SELECT state, candidate, VOTI
                FROM (
                         SELECT state, candidate, SUM(candidatevotes) as VOTI,
                                ROW_NUMBER() OVER (PARTITION BY state ORDER BY SUM(candidatevotes) DESC) as rn
                         FROM election_data
                         WHERE year = :year
                         GROUP BY state, candidate
                     ) AS ranked
                WHERE rn <= 2
                ORDER BY state, VOTI DESC
                ";
        $result = $pdo->prepare($sql);
        $result->execute([
            'year' => $year
        ]);
        return $result->fetchAll();
    }



    public static function getNameState() {
        $pdo = Connection::getInstance();
        $sql = "SELECT name
                FROM state
                ORDER BY name";
        $results = $pdo -> query($sql);
        return $results -> fetchAll();
    }

    public static function getOneStateInfo_on_year($year, $state) {
        $pdo = Connection::getInstance();
        $sql = "SELECT state, candidate, SUM(candidatevotes) as VOTI, totalvotes, party_simplified,
                       party_detailed
                FROM election_data
                WHERE year = :year
                  AND state = :state
                GROUP BY candidate
                ORDER BY VOTI DESC";
        $result = $pdo->prepare($sql);
        $result->execute([
            'year' => $year,
            'state' => $state,
        ]);
        return $result->fetchAll();
    }




    public static function getVote_Party_on_year($year) {
        $pdo = Connection::getInstance();
        $sql = "SELECT
                VotiPartito / total_votes * 100 AS percentuale_voti,
                party_simplified
                FROM
                    (SELECT SUM(candidatevotes) AS VotiPartito, party_simplified
                     FROM election_data
                     WHERE year = :year
                     GROUP BY party_simplified) AS partito_voti,
                    (SELECT SUM(totalvotes) AS total_votes
                     FROM (SELECT DISTINCT totalvotes, state
                           FROM election_data
                           WHERE year = :year) AS subquery) AS totali_voti
                ORDER BY percentuale_voti DESC";
        $result = $pdo->prepare($sql);
        $result->execute([
            'year' => $year,
        ]);
        return $result->fetchAll();
    }



}