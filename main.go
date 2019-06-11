package main

import (
	"flag"
	"time"

	log "github.com/golang/glog"
)

const Iterations = 9999999999

func init() {
	flag.Parse()
	flag.Lookup("logtostderr").Value.Set("true")
}

func main() {

	f := fib()

	start := time.Now()

	for i := 1; i <= Iterations; i++ {
		f()
	}

	elapsed := time.Since(start)

	log.Infof("Time: %v", elapsed)

	log.Flush()
}

func fib() func() int {
	a, b := 0, 1
	return func() int {
		a, b = b, a+b
		return a
	}
}
