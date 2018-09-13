package main

import (
	"fmt"
	"image"
	"image/png"
	"os"
	"os/exec"
	"time"

	"./cv"
	"github.com/jehiah/go-strftime"
)

func screencap() string {
	screencapName := strftime.Format("/sdcard/log/%m-%d-%H:%M:%S.png", time.Now())
	fmt.Println(screencapName)
	exec.Command("screencap", "-p", screencapName).Run()
	return screencapName
}

func operateOn(img image.Image) {

}

func click(x, y int) {
	err := exec.Command("sh", "-c", fmt.Sprintf("input tap %v %v", x, y)).Run()
	if err != nil {
		fmt.Printf("%v\n", err)
	}
	fmt.Println("click ", x, ",", y)
}

func main() {

	fmt.Printf("before exe monkey\n")
	exec.Command("sh","-c", "monkey -p com.touchsprite.android -c android.intent.category.LAUNCHER 1").Run()
	fmt.Printf("after exe monkey\n")
	time.Sleep(12 * time.Second)
	

	notRunningFloaterFile, _ := os.Open("/sdcard/go/not_running.png")
	notRunningFloaterPattern, _ := png.Decode(notRunningFloaterFile)
	defer notRunningFloaterFile.Close()

	runningFloaterFile, _ := os.Open("/sdcard/go/running.png")
	runningFloaterPattern, _ := png.Decode(runningFloaterFile)
	defer runningFloaterFile.Close()

	stopFile, _ := os.Open("/sdcard/go/stop.png")
	stopPattern, _ := png.Decode(stopFile)
	defer stopFile.Close()

	name := screencap()
	time.Sleep(8 * time.Second)
	file1, _ := os.Open(name)
	defer file1.Close()

	img1, _ := png.Decode(file1)

	for {

		sim, x, y := cv.Match(img1, notRunningFloaterPattern, 0, 0, 117, 2248)
		if sim < 0.08 {
			sim1, _, _ := cv.Match(img1, stopPattern, 170, 0, 320, 2248)
			if sim1 < 0.08 {
				click(x+100, y)
			} else {
				click(x, y)
				time.Sleep(2 * time.Second)
				click(x+100, y)
			}
			break
		}

		sim, x, y = cv.Match(img1, runningFloaterPattern, 0, 0, 117, 2248)
		if sim < 0.08 {
			sim1, p, q := cv.Match(img1, stopPattern, 170, 0, 320, 2248)
			if sim1 < 0.08 {
				click(p, q)
				time.Sleep(6 * time.Second)
				click(x+100, y)
			} else {
				click(x, y)
				time.Sleep(2 * time.Second)
				click(x+200, y)
				time.Sleep(6 * time.Second)
				click(x+100, y)
			}
			break
		}

		time.Sleep(2 * time.Second)
	}
}
