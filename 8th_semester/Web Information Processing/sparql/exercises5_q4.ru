PREFIX : <http://example.org/>

INSERT { 
  GRAPH ?c { 
    ?p :winner ?w . 
	?w :country ?c 
  } 
} WHERE {
  GRAPH ?g { 
    ?p :winner ?w . 
	?w :country ?c 
  }
  ?p a :NobelPrizeLiterature .
}