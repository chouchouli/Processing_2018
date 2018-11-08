This is the code for you to detect the one-pixel outline of a figure in black and white 
The basic idea is to detect the point that the other four(up, down, right and left) point arounds it has different color

This code is based on coordinates
PVector is used to store the position(the xy coordinates)

1- detect the point which one of the four point around it has different color when comparing to this center point
2- store the x and y coordinates of the points detected in a new PVector array called potision
3- draw the circle based on the position record in that array


Thoughts:
	# The reason why I need one-pixel outline is that I am going to calculate the curvature at every point on the outline, which means two-pixel outline can just mess the algorithm up. However, if you just want the outline to show up, one-pixel or two-pixel are both ok. Because if you zoom out, there is no difference for eyes.
	# At first I tried a lot but the results is always a two-pixel outline. That is because I didn't specify that the center point color should be black, which means I also detece the outer outlin of the figure which the center points are white however they also have different color around them. So first detect if the center point's color is what you need.
	# There are other much easier way to extract the outline however there are both pros and cons:
		1. using Matlab - 
			# 4 lines coding which is really easy. 
			# Only can output data in Mat form or Txt form and then import to processing or other creative coding software for further use.
			# You need a license for Matlab or 30-day free trial	
		2. OpenCV
			# I had never used OpenCv before, the learning curve is longer
			# More useful for complex photos with complex color. I would choose to just use Processing for my black and white project