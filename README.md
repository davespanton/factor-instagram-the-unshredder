# The Unshredder

[Instagram engineering challenge 'The Unshredder'](http://instagram-engineering.tumblr.com/post/12651721845/instagram-engineering-challenge-the-unshredder) implemented in Factor.

It works by comparing the chrominance of adjacent pixels at the edges of each stripe next to each other stripe. 

This gives a score for each possible stripe pair. These scores are then summed for every combination of all the stripes as a full image.

The lowest of these is the most likely full, unshredded image.

### Installing

Clone the project somewhere on your Factor root. It will then be available to use with `USE: unshredder` or similar.

### Usage

The `unshred` word expects an [image](http://docs.factorcode.org/content/word-image%2Cimages.html) object on the stack and will leave a (hopefully) unshredded image.

### Testing

To run the tests make sure the vocabulary is loaded (`USE: unshredder`) and then `"unshredder" test`. If there are no errors, then all is well.

#### License

Code is BSD license, [same as Factor](http://factorcode.org/license.txt).

The orangutan test image is licensed under Creative Commons 2.0 attribution. The original by Humberto Moreno can be [found here](http://www.flickr.com/photos/18560756@N05/5209988807/in/photolist-8Woyae).
