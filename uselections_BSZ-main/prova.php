<?php

function getPresidentImage($name) {
    $url = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&pithumbsize=300&titles=" . urlencode($name);

    // Effettua la richiesta all'API di Wikipedia
    $response = file_get_contents($url);
    $data = json_decode($response, true);

    // Estrai l'URL dell'immagine se disponibile
    if (isset($data['query']['pages'])) {
        $page = current($data['query']['pages']);
        if (isset($page['thumbnail']['source'])) {
            return $page['thumbnail']['source'];
        }
    }

    // Se non è stata trovata nessuna immagine, restituisci null
    return null;
}

// Esempio di utilizzo
$presidentName = "BUSH, GEORGE"; // Cambia il nome del presidente secondo le tue esigenze
$imageUrl = getPresidentImage($presidentName);
if ($imageUrl) {
    echo "URL dell'immagine del presidente: " . $imageUrl;
} else {
    echo "Immagine del presidente non trovata.";
}





function reverseNameFormat($nomeCompleto) {
    // Rimuovi eventuali virgole dal nome completo
    $nomeCompleto = str_replace(',', '', $nomeCompleto);

    // Dividi il nome in un array usando lo spazio come separatore
    $nomeCompletoArray = explode(" ", $nomeCompleto);

    // Controlla il numero di elementi nel nome
    $numeroElementi = count($nomeCompletoArray);

    if ($numeroElementi === 4) {
        // Se ha 4 elementi, controlla se il terzo elemento inizia con "H."
        if (strpos($nomeCompletoArray[2], 'H.') === 0) {
            // Se sì, restituisci "George Bush"
            return "George Bush";
        } else {
            // Altrimenti, unisci il secondo e il terzo (nome e cognome) e il quarto viene ignorato
            return ucfirst(strtolower($nomeCompletoArray[1])) . " " . ucfirst(strtolower($nomeCompletoArray[0]));
        }
    } else if ($numeroElementi === 3) {
        // Se ha 3 elementi, unisci solo i primi due (cognome e nome)
        return ucfirst(strtolower($nomeCompletoArray[1])) . " " . ucfirst(strtolower($nomeCompletoArray[0]));
    } else if ($numeroElementi === 2) {
        // Se ha 2 elementi, formatta cognome e nome con la maiuscola iniziale
        return ucfirst(strtolower($nomeCompletoArray[1])) . " " . ucfirst(strtolower($nomeCompletoArray[0]));
    } else {
        // Se il nome non è valido, restituisce un messaggio di errore
        return "Nome non valido";
    }
}

// Test della funzione
echo reverseNameFormat("BUSH, GEORGE H.W."); // Restituirà "George Bush"






?>
