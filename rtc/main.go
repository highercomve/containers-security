package main

import (
	"fmt"
	"time"

	"github.com/cleroux/rtc"
)

func main() {
	c, err := rtc.NewRTC("/dev/rtc0")
	if err != nil {
		panic(err)
	}
	defer c.Close()

	t, err := c.Time()
	if err != nil {
		panic(err)
	}

	fmt.Printf("Current time: %v\n", t.Format(time.RFC3339))
}
