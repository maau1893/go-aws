package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", HelloServer)
	http.HandleFunc("/hello", HelloServer2)
	http.ListenAndServe(":8080", nil)
}
func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
}

func HelloServer2(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello Marc")
}
