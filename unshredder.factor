! Copyright (C) 2013 Dave Spanton.
! See http://factorcode.org/license.txt for BSD license.

USING: accessors arrays byte-arrays grouping kernel locals math random sequences sequences.deep sequences.extras sequences.generalizations ;

IN: unshredder

: >pixels ( image -- arr )
    4 group ;

: rows ( image -- arr )
    dup bitmap>> >pixels swap dim>> first group ;

: >bitmap ( arr -- bytes )
    flatten >byte-array ;

: update-bitmap ( image bytes w h -- image )
    [ >bitmap >>bitmap ] 2dip 2array >>dim ;

:: >YUV ( r g b -- yuv )
    r 0.257 * g 0.504 * + b 0.098 * + 16 +
    r -0.148 * g 0.291 *  - b 0.439 * + 128 +
    r 0.439 * g 0.368 * - b 0.071 * - 128 +
    3array ;

: compare-pixels ( px px -- diff )
    [ first3 >YUV rest ] bi@ [ - abs sq ] 2map-sum ;

: columns ( arr -- arr )
    [ 32 group ] map flip ;

: stripe ( image -- arr )
    rows columns ;

: un-stripe ( arr -- bytearr )
    flip flatten >byte-array ;

: neighbours ( arr arr -- arr arr )
    [ last ] map swap [ first ] map ;

:: compare-to-left ( arr -- arr )
   arr first length :> l
   arr dup cartesian-product
   [ :> i [ :> j i j =
            [ drop l 1024 * ]
            [ first2 neighbours [ compare-pixels ] 2map sum ]
            if ]
       map-index ] map-index ;

: right-of-index ( n arr -- n n )
    [ nth ] with map dup infimum [ swap index ] keep ;

:: position-of ( comparison -- arr )
    comparison
    [ 1array :> out-order! :> row 0 :> score!
      [ out-order length comparison length < ]
      [ out-order last comparison right-of-index
        score + score!
        out-order swap suffix out-order! ]
      while { out-order score } ] map-index ;

: arrange-stripes ( arr arr -- arr )
    swap nths  ;

: best-route ( arr -- arr )
    [ second ] infimum-by first ;

: shred ( image -- image )
   dup stripe randomize un-stripe >>bitmap ;

: unshred ( image -- image )
    dup stripe dup compare-to-left position-of best-route arrange-stripes
    un-stripe >>bitmap ;
