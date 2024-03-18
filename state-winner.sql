
SELECT po, party_detailed FROM
    (SELECT state.po, party_detailed
     FROM party INNER JOIN vote ON id_party = party.id
                INNER JOIN state ON id_state = state.id
                INNER JOIN election ON id_election = election.id
     WHERE YEAR = 2000 AND (party.party_detailed = 'DEMOCRAT' OR party.party_detailed = 'REPUBLICAN')) AS a
GROUP BY po;