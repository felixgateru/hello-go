package main

import (
	"encoding/json"
	"log"
	"math/rand/v2"
	"net/http"
)

type Response struct {
	Number int `json:"number"`
}

func randomHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	num := rand.IntN(10) + 1

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(Response{Number: num})
}

func main() {
	http.HandleFunc("/random", randomHandler)

	log.Println("server starting on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
