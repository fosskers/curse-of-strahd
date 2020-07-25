data Travel = Travel { _hex :: Float
                     , _di :: Float
                     , _nt :: Float
                     , _nr :: Float
                     , _ft :: Float
                     , _fr :: Float
                     } deriving (Show)

-- | Travel time statistics, given a number of hexes.
travel :: Float -> Travel
travel h = Travel h d nt nr ft fr
  where d = h / 4
        nt = d / 3
        nr = nt * 2
        ft = d / 4
        fr = ft * 2

hexes :: [Float]
hexes = [12, 7, 5, 23, 8, 1, 9, 22, 64, 75]
