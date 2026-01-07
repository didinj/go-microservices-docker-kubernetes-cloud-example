package main

import (
	"log"
	"net/http"

	"hello-service/handlers"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/hello", handlers.HelloHandler)
	mux.HandleFunc("/health", handlers.HealthHandler)

	log.Println("Hello Service running on :8081")
	log.Fatal(http.ListenAndServe(":8081", mux))
}
