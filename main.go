package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
)

type Response struct {
	Message string `json:"message"`
	Status  string `json:"status"`
}

func main() {
	// Cloud Runは環境変数 PORT を指定してくるため、それに合わせる
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// エンドポイントの設定
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		response := Response{
			Message: "Hello from Cloud Run with Go!",
			Status:  "success",
		}
		json.NewEncoder(w).Encode(response)
	})

	log.Printf("Server is running on port %s...", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatalf("Server failed: %v", err)
	}
}