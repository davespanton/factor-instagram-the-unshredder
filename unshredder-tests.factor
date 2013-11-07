! Copyright (C) 2013 Dave Spanton.
! See http://factorcode.org/license.txt for BSD license.

USING: kernel tools.test images.loader quotations unshredder ;

IN: unshredder.tests

: unshred-test ( expected actual -- )
    [ load-image ] bi@ unshred [ 1quotation ] bi@ unit-test ;

"vocab:unshredder/testing/tokyo.png" "vocab:unshredder/testing/tokyo_shred.png" unshred-test
"vocab:unshredder/testing/orangutan.png" "vocab:unshredder/testing/orangutan_shred.png" unshred-test
