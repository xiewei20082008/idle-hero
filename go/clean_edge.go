package main

import (
	"image/png"
	"log"
	"os"

	"./cv"
)

func main() {
	file, _ := os.Open(os.Args[1])
	img, _ := png.Decode(file)
	defer file.Close()

	ladder_1, ladder_2 := cv.GetLadderDiff(img)

	for i, v := range ladder_1 {
		for j, vv := range v {
			if vv == true {
				cv.CleanPixel(img, i, j)
				cv.CleanPixel(img, i, j+1)
			}
		}
	}

	for i, v := range ladder_2 {
		for j, vv := range v {
			if vv == true {
				cv.CleanPixel(img, i, j)
				cv.CleanPixel(img, i+1, j)
			}
		}
	}

	f, err := os.Create("./tmp.png")
	if err != nil {
		log.Fatal(err)
	}

	if err := png.Encode(f, img); err != nil {
		f.Close()
		log.Fatal(err)
	}

	if err := f.Close(); err != nil {
		log.Fatal(err)
	}
}
