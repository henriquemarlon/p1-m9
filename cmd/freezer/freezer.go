package main

import (
	"sync"
	"github.com/henriquemarlon/p1-m9/internal/domain/entity"
)


func main() {
	numStations := 1
	var wg sync.WaitGroup

	for i := 0; i < numStations; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			entity.StartFreezer("tcp://broker:1891")
		}()
	}
	wg.Wait()
}