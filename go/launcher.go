package main

import (
	"fmt"
	"time"

	"github.com/jehiah/go-strftime"
)

func main() {
	screencapName := strftime.Format("/sdcard/log/%m-%d-%H:%M:%S.png", time.Now())
	fmt.Println(screencapName)
}
