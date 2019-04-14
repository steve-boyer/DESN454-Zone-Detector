# DESN454-Zone-Detector
Processing  Arduino Zone Detector using Firmata and OpenCV

A quick demo combining Arduino Firmata and OpenCV to create a zone detector.
opencv.max is used to find the brightest pixel and identify which of 4 screen quadrants the brightest pixel exists in. It will write a digital HIGH to 1 of 4 pins depending upon the quadrant.
