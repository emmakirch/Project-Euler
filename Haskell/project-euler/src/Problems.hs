module Problems where

import Data.Char
import Data.List
import Data.List.Split
import Data.Numbers.Primes

-- Problem 1

-- If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

-- Find the sum of all the multiples of 3 or 5 below 1000.

mergeNoDups :: Ord a => [a] -> [a] -> [a]
mergeNoDups xs [] = xs
mergeNoDups [] ys = ys
mergeNoDups xx@(x:xs) yy@(y:ys) | x == y = x : mergeNoDups xs ys
                                | x < y  = x : mergeNoDups xs yy
                                | y < x  = y : mergeNoDups xx ys

p001 = sum $ mergeNoDups [3, 6..999] [5, 10..999]


-- Problem 2

-- Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

-- 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

-- By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

genFibs :: Num a => a -> a -> [a]
genFibs x y = (x :) . genFibs y $ x + y

p002 = sum $ filter even $ takeWhile (<=4000000) $ genFibs 1 2


-- Problem 3

-- The prime factors of 13195 are 5, 7, 13 and 29.

-- What is the largest prime factor of the number 600851475143 ?

isPrime' :: Int -> Bool
isPrime' 2 = True
isPrime' x | x < 2     = False
          | otherwise = not $ or $ map (==0) [mod x p | p <- takeWhile ((<= sqrt (fromIntegral x)) . fromIntegral) primes']

primes' = filter isPrime' [1..]

primeFactors' :: Int -> [Int]
primeFactors' x = checkFactors x primes'
    where checkFactors 1 _ = []
          checkFactors n pp@(p:ps) | mod n p == 0 = p : checkFactors (div n p) pp
                                   | otherwise    = checkFactors n ps

p003 = maximum $ primeFactors 600851475143


-- Problem 4

-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

-- Find the largest palindrome made from the product of two 3-digit numbers.

isPalindromic :: Int -> Bool
isPalindromic = isPalindrome . show
    where isPalindrome "" = True
          isPalindrome [c] = True
          isPalindrome (c:cs) | c == (last cs) = isPalindrome $ init cs
                              | otherwise      = False

p004 = maximum $ filter isPalindromic [x * y | x <- [100..999], y <- [100..999]]


-- Problem 5

-- 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

-- What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

p005 = foldr1 lcm [1..20]


-- Problem 6

-- The sum of the squares of the first ten natural numbers is,

-- 1^2+2^2+...+10^2=385

-- The square of the sum of the first ten natural numbers is,

-- (1+2+...+10)^2=55^2=3025

-- Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025−385=2640.

-- Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

sumOfSquares :: Int -> Int
sumOfSquares n = foldr1 (+) [x^2 | x <- [1..n]]

squareOfSum :: Int -> Int
squareOfSum n = (sum [1..n])^2

p006 = squareOfSum 100 - sumOfSquares 100


-- Problem 7

-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

-- What is the 10001st prime number?

p007 = primes !! 10000


-- Problem 8

-- The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.

{- 73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450 -}

-- Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?

subMaximumArrayProduct :: (Num a, Ord a) => Int -> [a] -> a
subMaximumArrayProduct n [] = 0
subMaximumArrayProduct n xx@(x:xs) = max prod rProd
    where prod = product $ take n xx
          rProd = subMaximumArrayProduct n xs

getDigits :: Integer -> [Int]
getDigits n = map (\x -> ord x - ord '0') $ show n

p008 = subMaximumArrayProduct 13 $ getDigits 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450


-- Problem 9

-- A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

-- a^2 + b^2 = c^2
-- For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

-- There exists exactly one Pythagorean triplet for which a + b + c = 1000.
-- Find the product abc.

findPythagoreanTriples :: Int -> [(Int, Int, Int)]
findPythagoreanTriples x = [(a, b, c) | a <- [1..(x-2)], b <- [a..(x-a-1)], let c = x - a - b, a^2 + b^2 == c^2]

product3Tuple :: Num a => (a, a, a) -> a
product3Tuple (a, b, c) = a * b * c

p009 = product3Tuple $ head $ findPythagoreanTriples 1000


-- Problem 10

-- The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

-- Find the sum of all the primes below two million.

p010 = sum $ takeWhile (< 2000000) primes


-- Problem 11

-- In the 20×20 grid below, four numbers along a diagonal line have been marked in red.

-- 08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
-- 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
-- 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
-- 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
-- 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
-- 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
-- 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
-- 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
-- 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
-- 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
-- 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
-- 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
-- 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
-- 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
-- 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
-- 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
-- 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
-- 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
-- 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
-- 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48

-- The product of these numbers is 26 × 63 × 78 × 14 = 1788696.

-- What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?

findMaxHorizontalProduct :: Int -> [[Int]] -> Int
findMaxHorizontalProduct len grid = f grid
    where f [] = 0
          f (x:xs) | length x >= len = max (product $ take 4 x) $ f $ tail x : xs
                   | otherwise       = f xs

findMaxVerticalProduct :: Int -> [[Int]] -> Int
findMaxVerticalProduct len grid = f 0 grid
    where f _ ([]:_) = 0
          f i xs | length xs - i < len = f 0 $ map tail xs
                 | otherwise           = max (product $ take len $ map head xs) $ f (i + 1) xs

findMaxMainDiagonalProduct :: Int -> [[Int]] -> Int
findMaxMainDiagonalProduct len grid = f 0 grid
    where f i xx@(x:xs) | length xx < 4    = 0
                        | length x - i < 4 = f 0 xs
                        | otherwise        = max (f (i + 1) xx) $ product $ take len [n | d <- [0..], let n = (xx !! d) !! (d + i)]

findMaxAltDiagonalProduct :: Int -> [[Int]] -> Int
findMaxAltDiagonalProduct len grid = f (len - 1) grid
    where f i xx@(x:xs) | length xx < 4     = 0
                        | length x - i == 0 = f (len - 1) xs
                        | otherwise         = max (f (i + 1) xx) $ product $ take len [n | d <- [0..], let n = (xx !! d) !! (i - d)]

findMaxGridProduct :: Int -> [[Int]] -> Int
findMaxGridProduct l g = max (findMaxHorizontalProduct l g) $ max (findMaxVerticalProduct l g) $ max (findMaxMainDiagonalProduct l g) $ findMaxAltDiagonalProduct l g

p011 = findMaxGridProduct 4 [
    [08, 02, 22, 97, 38, 15, 00, 40, 00, 75, 04, 05, 07, 78, 52, 12, 50, 77, 91, 08],
    [49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 04, 56, 62, 00],
    [81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 03, 49, 13, 36, 65],
    [52, 70, 95, 23, 04, 60, 11, 42, 69, 24, 68, 56, 01, 32, 56, 71, 37, 02, 36, 91],
    [22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80],
    [24, 47, 32, 60, 99, 03, 45, 02, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50],
    [32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70],
    [67, 26, 20, 68, 02, 62, 12, 20, 95, 63, 94, 39, 63, 08, 40, 91, 66, 49, 94, 21],
    [24, 55, 58, 05, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72],
    [21, 36, 23, 09, 75, 00, 76, 44, 20, 45, 35, 14, 00, 61, 33, 97, 34, 31, 33, 95],
    [78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 03, 80, 04, 62, 16, 14, 09, 53, 56, 92],
    [16, 39, 05, 42, 96, 35, 31, 47, 55, 58, 88, 24, 00, 17, 54, 24, 36, 29, 85, 57],
    [86, 56, 00, 48, 35, 71, 89, 07, 05, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58],
    [19, 80, 81, 68, 05, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 04, 89, 55, 40],
    [04, 52, 08, 83, 97, 35, 99, 16, 07, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66],
    [88, 36, 68, 87, 57, 62, 20, 72, 03, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69],
    [04, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 08, 46, 29, 32, 40, 62, 76, 36],
    [20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 04, 36, 16],
    [20, 73, 35, 29, 78, 31, 90, 01, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 05, 54],
    [01, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 01, 89, 19, 67, 48]]


-- Problem 12

-- The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:

-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

-- Let us list the factors of the first seven triangle numbers:

--  1: 1
--  3: 1,3
--  6: 1,2,3,6
-- 10: 1,2,5,10
-- 15: 1,3,5,15
-- 21: 1,3,7,21
-- 28: 1,2,4,7,14,28
-- We can see that 28 is the first triangle number to have over five divisors.

-- What is the value of the first triangle number to have over five hundred divisors?

triangleNumbers = [div (n^2 - n) 2 | n <- [2..]]

getDivisors :: Int -> [Int]
getDivisors x = combine l1 $ reverse l2
    where factorPairs = [(m, n) | m <- [1..(ceiling $ sqrt $ fromIntegral x)], m^2 <= x, mod x m == 0, let n = div x m]
          (l1, l2) = unzip factorPairs
          combine xs l@(y:ys) | last xs == y = xs ++ ys
                              | otherwise    = xs ++ l

p012 = fst $ head $ dropWhile ((<= 500) . length . snd) $ zip triangleNumbers $ map getDivisors triangleNumbers


-- Problem 13

-- Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

-- 37107287533902102798797998220837590246510135740250
-- 46376937677490009712648124896970078050417018260538
-- 74324986199524741059474233309513058123726617309629
-- 91942213363574161572522430563301811072406154908250
-- 23067588207539346171171980310421047513778063246676
-- 89261670696623633820136378418383684178734361726757
-- 28112879812849979408065481931592621691275889832738
-- 44274228917432520321923589422876796487670272189318
-- 47451445736001306439091167216856844588711603153276
-- 70386486105843025439939619828917593665686757934951
-- 62176457141856560629502157223196586755079324193331
-- 64906352462741904929101432445813822663347944758178
-- 92575867718337217661963751590579239728245598838407
-- 58203565325359399008402633568948830189458628227828
-- 80181199384826282014278194139940567587151170094390
-- 35398664372827112653829987240784473053190104293586
-- 86515506006295864861532075273371959191420517255829
-- 71693888707715466499115593487603532921714970056938
-- 54370070576826684624621495650076471787294438377604
-- 53282654108756828443191190634694037855217779295145
-- 36123272525000296071075082563815656710885258350721
-- 45876576172410976447339110607218265236877223636045
-- 17423706905851860660448207621209813287860733969412
-- 81142660418086830619328460811191061556940512689692
-- 51934325451728388641918047049293215058642563049483
-- 62467221648435076201727918039944693004732956340691
-- 15732444386908125794514089057706229429197107928209
-- 55037687525678773091862540744969844508330393682126
-- 18336384825330154686196124348767681297534375946515
-- 80386287592878490201521685554828717201219257766954
-- 78182833757993103614740356856449095527097864797581
-- 16726320100436897842553539920931837441497806860984
-- 48403098129077791799088218795327364475675590848030
-- 87086987551392711854517078544161852424320693150332
-- 59959406895756536782107074926966537676326235447210
-- 69793950679652694742597709739166693763042633987085
-- 41052684708299085211399427365734116182760315001271
-- 65378607361501080857009149939512557028198746004375
-- 35829035317434717326932123578154982629742552737307
-- 94953759765105305946966067683156574377167401875275
-- 88902802571733229619176668713819931811048770190271
-- 25267680276078003013678680992525463401061632866526
-- 36270218540497705585629946580636237993140746255962
-- 24074486908231174977792365466257246923322810917141
-- 91430288197103288597806669760892938638285025333403
-- 34413065578016127815921815005561868836468420090470
-- 23053081172816430487623791969842487255036638784583
-- 11487696932154902810424020138335124462181441773470
-- 63783299490636259666498587618221225225512486764533
-- 67720186971698544312419572409913959008952310058822
-- 95548255300263520781532296796249481641953868218774
-- 76085327132285723110424803456124867697064507995236
-- 37774242535411291684276865538926205024910326572967
-- 23701913275725675285653248258265463092207058596522
-- 29798860272258331913126375147341994889534765745501
-- 18495701454879288984856827726077713721403798879715
-- 38298203783031473527721580348144513491373226651381
-- 34829543829199918180278916522431027392251122869539
-- 40957953066405232632538044100059654939159879593635
-- 29746152185502371307642255121183693803580388584903
-- 41698116222072977186158236678424689157993532961922
-- 62467957194401269043877107275048102390895523597457
-- 23189706772547915061505504953922979530901129967519
-- 86188088225875314529584099251203829009407770775672
-- 11306739708304724483816533873502340845647058077308
-- 82959174767140363198008187129011875491310547126581
-- 97623331044818386269515456334926366572897563400500
-- 42846280183517070527831839425882145521227251250327
-- 55121603546981200581762165212827652751691296897789
-- 32238195734329339946437501907836945765883352399886
-- 75506164965184775180738168837861091527357929701337
-- 62177842752192623401942399639168044983993173312731
-- 32924185707147349566916674687634660915035914677504
-- 99518671430235219628894890102423325116913619626622
-- 73267460800591547471830798392868535206946944540724
-- 76841822524674417161514036427982273348055556214818
-- 97142617910342598647204516893989422179826088076852
-- 87783646182799346313767754307809363333018982642090
-- 10848802521674670883215120185883543223812876952786
-- 71329612474782464538636993009049310363619763878039
-- 62184073572399794223406235393808339651327408011116
-- 66627891981488087797941876876144230030984490851411
-- 60661826293682836764744779239180335110989069790714
-- 85786944089552990653640447425576083659976645795096
-- 66024396409905389607120198219976047599490197230297
-- 64913982680032973156037120041377903785566085089252
-- 16730939319872750275468906903707539413042652315011
-- 94809377245048795150954100921645863754710598436791
-- 78639167021187492431995700641917969777599028300699
-- 15368713711936614952811305876380278410754449733078
-- 40789923115535562561142322423255033685442488917353
-- 44889911501440648020369068063960672322193204149535
-- 41503128880339536053299340368006977710650566631954
-- 81234880673210146739058568557934581403627822703280
-- 82616570773948327592232845941706525094512325230608
-- 22918802058777319719839450180888072429661980811197
-- 77158542502016545090413245809786882778948721859617
-- 72107838435069186155435662884062257473692284509516
-- 20849603980134001723930671666823555245252804609722
-- 53503534226472524250874054075591789781264330331690

get10Digits :: Integer -> Int
get10Digits = read . (take 10) . show

p013 = get10Digits $ sum [
    37107287533902102798797998220837590246510135740250,
    46376937677490009712648124896970078050417018260538,
    74324986199524741059474233309513058123726617309629,
    91942213363574161572522430563301811072406154908250,
    23067588207539346171171980310421047513778063246676,
    89261670696623633820136378418383684178734361726757,
    28112879812849979408065481931592621691275889832738,
    44274228917432520321923589422876796487670272189318,
    47451445736001306439091167216856844588711603153276,
    70386486105843025439939619828917593665686757934951,
    62176457141856560629502157223196586755079324193331,
    64906352462741904929101432445813822663347944758178,
    92575867718337217661963751590579239728245598838407,
    58203565325359399008402633568948830189458628227828,
    80181199384826282014278194139940567587151170094390,
    35398664372827112653829987240784473053190104293586,
    86515506006295864861532075273371959191420517255829,
    71693888707715466499115593487603532921714970056938,
    54370070576826684624621495650076471787294438377604,
    53282654108756828443191190634694037855217779295145,
    36123272525000296071075082563815656710885258350721,
    45876576172410976447339110607218265236877223636045,
    17423706905851860660448207621209813287860733969412,
    81142660418086830619328460811191061556940512689692,
    51934325451728388641918047049293215058642563049483,
    62467221648435076201727918039944693004732956340691,
    15732444386908125794514089057706229429197107928209,
    55037687525678773091862540744969844508330393682126,
    18336384825330154686196124348767681297534375946515,
    80386287592878490201521685554828717201219257766954,
    78182833757993103614740356856449095527097864797581,
    16726320100436897842553539920931837441497806860984,
    48403098129077791799088218795327364475675590848030,
    87086987551392711854517078544161852424320693150332,
    59959406895756536782107074926966537676326235447210,
    69793950679652694742597709739166693763042633987085,
    41052684708299085211399427365734116182760315001271,
    65378607361501080857009149939512557028198746004375,
    35829035317434717326932123578154982629742552737307,
    94953759765105305946966067683156574377167401875275,
    88902802571733229619176668713819931811048770190271,
    25267680276078003013678680992525463401061632866526,
    36270218540497705585629946580636237993140746255962,
    24074486908231174977792365466257246923322810917141,
    91430288197103288597806669760892938638285025333403,
    34413065578016127815921815005561868836468420090470,
    23053081172816430487623791969842487255036638784583,
    11487696932154902810424020138335124462181441773470,
    63783299490636259666498587618221225225512486764533,
    67720186971698544312419572409913959008952310058822,
    95548255300263520781532296796249481641953868218774,
    76085327132285723110424803456124867697064507995236,
    37774242535411291684276865538926205024910326572967,
    23701913275725675285653248258265463092207058596522,
    29798860272258331913126375147341994889534765745501,
    18495701454879288984856827726077713721403798879715,
    38298203783031473527721580348144513491373226651381,
    34829543829199918180278916522431027392251122869539,
    40957953066405232632538044100059654939159879593635,
    29746152185502371307642255121183693803580388584903,
    41698116222072977186158236678424689157993532961922,
    62467957194401269043877107275048102390895523597457,
    23189706772547915061505504953922979530901129967519,
    86188088225875314529584099251203829009407770775672,
    11306739708304724483816533873502340845647058077308,
    82959174767140363198008187129011875491310547126581,
    97623331044818386269515456334926366572897563400500,
    42846280183517070527831839425882145521227251250327,
    55121603546981200581762165212827652751691296897789,
    32238195734329339946437501907836945765883352399886,
    75506164965184775180738168837861091527357929701337,
    62177842752192623401942399639168044983993173312731,
    32924185707147349566916674687634660915035914677504,
    99518671430235219628894890102423325116913619626622,
    73267460800591547471830798392868535206946944540724,
    76841822524674417161514036427982273348055556214818,
    97142617910342598647204516893989422179826088076852,
    87783646182799346313767754307809363333018982642090,
    10848802521674670883215120185883543223812876952786,
    71329612474782464538636993009049310363619763878039,
    62184073572399794223406235393808339651327408011116,
    66627891981488087797941876876144230030984490851411,
    60661826293682836764744779239180335110989069790714,
    85786944089552990653640447425576083659976645795096,
    66024396409905389607120198219976047599490197230297,
    64913982680032973156037120041377903785566085089252,
    16730939319872750275468906903707539413042652315011,
    94809377245048795150954100921645863754710598436791,
    78639167021187492431995700641917969777599028300699,
    15368713711936614952811305876380278410754449733078,
    40789923115535562561142322423255033685442488917353,
    44889911501440648020369068063960672322193204149535,
    41503128880339536053299340368006977710650566631954,
    81234880673210146739058568557934581403627822703280,
    82616570773948327592232845941706525094512325230608,
    22918802058777319719839450180888072429661980811197,
    77158542502016545090413245809786882778948721859617,
    72107838435069186155435662884062257473692284509516,
    20849603980134001723930671666823555245252804609722,
    53503534226472524250874054075591789781264330331690]


-- Problem 14

-- The following iterative sequence is defined for the set of positive integers:

-- n → n/2 (n is even)
-- n → 3n + 1 (n is odd)

-- Using the rule above and starting with 13, we generate the following sequence:

-- 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
-- It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

-- Which starting number, under one million, produces the longest chain?

-- NOTE: Once the chain starts the terms are allowed to go above one million.

collatzLength :: Int -> Int
collatzLength x = f 1 x
    where f n x | x == 1    = n
                | even x    = f (n + 1) (div x 2)
                | otherwise = f (n + 1) (3 * x + 1)

p014 = fst $ maximumBy (\(_, l1) (_, l2) -> compare l1 l2) $ zip [1..999999] $ map collatzLength [1..999999]


-- Problem 15

-- Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

-- How many such routes are there through a 20×20 grid?

getPaths :: Int -> Int -> Int
getPaths 0 _ = 1
getPaths _ 0 = 1
getPaths x y = paths !! (y - 1) !! x + paths !! y !! (x - 1)

paths = [[getPaths a b | a <- [0..]] | b <- [0..]]

p015 = getPaths 20 20


-- Problem 16

-- 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

-- What is the sum of the digits of the number 2^1000?

p016 = sum $ getDigits $ 2 ^ 1000


-- Problem 17

-- If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

-- If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

-- NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen)
-- contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

writtenInt :: Int -> String
writtenInt 1    = "one"
writtenInt 2    = "two"
writtenInt 3    = "three"
writtenInt 4    = "four"
writtenInt 5    = "five"
writtenInt 6    = "six"
writtenInt 7    = "seven"
writtenInt 8    = "eight"
writtenInt 9    = "nine"
writtenInt 10   = "ten"
writtenInt 11   = "eleven"
writtenInt 12   = "twelve"
writtenInt 13   = "thirteen"
writtenInt 15   = "fifteen"
writtenInt 18   = "eighteen"
writtenInt 20   = "twenty"
writtenInt 30   = "thirty"
writtenInt 40   = "forty"
writtenInt 50   = "fifty"
writtenInt 60   = "sixty"
writtenInt 70   = "seventy"
writtenInt 80   = "eighty"
writtenInt 90   = "ninety"
writtenInt 1000 = "one thousand"
writtenInt x | div x 10 == 1 = writtenInt (mod x 10) ++ "teen"
             | x < 100       = writtenInt (10 * div x 10) ++ '-' : writtenInt (mod x 10)
             | otherwise     = writtenInt (div x 100) ++ " hundred" ++ case mod x 100 of 0 -> ""
                                                                                         x -> " and " ++ writtenInt x

keepLetters :: String -> String
keepLetters "" = ""
keepLetters (x:xs) | isLetter x = x : keepLetters xs
                   | otherwise = keepLetters xs

p017 = sum $ map (length . keepLetters . writtenInt) [1..1000]


-- Problem 18

-- By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

-- 3
-- 7 4
-- 2 4 6
-- 8 5 9 3

-- That is, 3 + 7 + 4 + 9 = 23.

-- Find the maximum total from top to bottom of the triangle below:

-- 75
-- 95 64
-- 17 47 82
-- 18 35 87 10
-- 20 04 82 47 65
-- 19 01 23 75 03 34
-- 88 02 77 73 07 63 67
-- 99 65 04 28 06 16 70 92
-- 41 41 26 56 83 40 80 70 33
-- 41 48 72 33 47 32 37 16 94 29
-- 53 71 44 65 25 43 91 52 97 51 14
-- 70 11 33 28 77 73 17 78 39 68 17 57
-- 91 71 52 38 17 14 91 43 58 50 27 29 48
-- 63 66 04 68 89 53 67 30 73 16 69 87 40 31
-- 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

-- NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with
-- a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)

maxPath :: [[Int]] -> Int
maxPath [] = 0
maxPath ([x]:xs) = x + max (maxPath $ map tail xs) (maxPath $ map init xs)

p018 = maxPath [
    [75],
    [95, 64],
    [17, 47, 82],
    [18, 35, 87, 10],
    [20, 04, 82, 47, 65],
    [19, 01, 23, 75, 03, 34],
    [88, 02, 77, 73, 07, 63, 67],
    [99, 65, 04, 28, 06, 16, 70, 92],
    [41, 41, 26, 56, 83, 40, 80, 70, 33],
    [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
    [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
    [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
    [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
    [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
    [04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23]]


-- Problem 19

-- You are given the following information, but you may prefer to do some research for yourself.

-- 1 Jan 1900 was a Monday.
-- Thirty days has September,
-- April, June and November.
-- All the rest have thirty-one,
-- Saving February alone,
-- Which has twenty-eight, rain or shine.
-- And on leap years, twenty-nine.
-- A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
-- How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

data Date = Date {
    year  :: Int,
    month :: Int,
    day   :: Int
}

isEarlierMonth :: Date -> Date -> Bool
isEarlierMonth (Date y1 m1 d1) (Date y2 m2 d2) | y1 < y2   = True
                                               | y1 > y2   = False
                                               | m1 < m2   = True
                                               | m1 > m2   = False
                                               | d1 < d2   = True
                                               | otherwise = False

subtract1Month :: Date -> Date
subtract1Month (Date y 1 d) = Date (y - 1) 12 d
subtract1Month (Date y m d) = Date y (m - 1) d

isLeapYear :: Date -> Bool
isLeapYear (Date x _ _) | mod x 4 /= 0   = False
                        | mod x 100 /= 0 = True
                        | mod x 400 /= 0 = False
                        | otherwise      = True

getMonthLength :: Date -> Int
getMonthLength x@(Date y 2 _) | isLeapYear x = 29
                              | otherwise    = 28
getMonthLength (Date _ 4 _)  = 30
getMonthLength (Date _ 6 _)  = 30
getMonthLength (Date _ 9 _)  = 30
getMonthLength (Date _ 11 _) = 30
getMonthLength _             = 31

getStartingWeekday :: Date -> Int
getStartingWeekday (Date 1900 1 1) = 1
getStartingWeekday x@(Date _ _ 1) = let prev = subtract1Month x
                                    in mod (getStartingWeekday prev + getMonthLength prev) 7
getStartingWeekday (Date y m d)   = getStartingWeekday (Date y m 1)

getInitialSundays :: Date -> Date -> Int
getInitialSundays x y | isEarlierMonth y x        = 0
                      | getStartingWeekday y == 0 = 1 + (getInitialSundays x $ subtract1Month y)
                      | otherwise                 = getInitialSundays x $ subtract1Month y

p019 = getInitialSundays (Date 1901 1 1) (Date 2000 12 31)


-- Problem 20

-- n! means n × (n − 1) × ... × 3 × 2 × 1

-- For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
-- and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

-- Find the sum of the digits in the number 100!

fact :: Integral a => a -> a
fact 0 = 1
fact n = n * fact (n - 1)

p020 = sum $ getDigits $ fact 100


-- Problem 21

-- Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
-- If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

-- For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of
-- 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

-- Evaluate the sum of all the amicable numbers under 10000.

propDivisors :: Int -> [Int]
propDivisors 0 = []
propDivisors 1 = []
propDivisors x = 1 : combine l1 (reverse l2)
    where factorPairs = [(m, n) | m <- [2..(ceiling $ sqrt $ fromIntegral x)], m^2 <= x, mod x m == 0, let n = div x m]
          (l1, l2) = unzip factorPairs
          combine [] _ = []
          combine xs l@(y:ys) | last xs == y = xs ++ ys
                              | otherwise    = xs ++ l

isAmicable :: Int -> Bool
isAmicable x = let y = sum $ propDivisors x
               in if x == y then False else sum (propDivisors y) == x

p021 = sum $ filter isAmicable [1..9999]


-- Problem 22

-- Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
-- begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, 
-- multiply this value by its alphabetical position in the list to obtain a name score.

-- For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53,
-- is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

-- What is the total of all the name scores in the file?

stringValue :: String -> Int
stringValue = sum . map cValue
    where cValue c = ord c - ord 'A' + 1

p022 :: String -> Int
p022 fileContents = sum $ zipWith (\p s -> p * stringValue s) [1..] $ sort $ filter ((>0) . length) $ splitOn "," $ filter (/= '\"') fileContents


-- Problem 23
-- A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
-- For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

-- A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

-- As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24.
-- By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers.
-- However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be
-- expressed as the sum of two abundant numbers is less than this limit.

-- Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

properDivisors :: Int -> [Int]
properDivisors = init . getDivisors

isAbundant :: Int -> Bool
isAbundant n = n < sum (properDivisors n)

abundantNumbers = filter (isAbundant) [1..]

isSumOfAbundants :: Int -> Bool
isSumOfAbundants n = not $ null [ x | x <- takeWhile (< (div n 2 + 1)) abundantNumbers, isAbundant (n - x) ]

p023 = sum $ filter (not . isSumOfAbundants) [1..28123]


-- Problem 24
-- A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4.
-- If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

-- 012   021   102   120   201   210

-- What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

intPermutations :: [Int] -> [Int]
intPermutations = sort . map read . permutations . concat . map show

p024 = intPermutations [0..9] !! 999999


-- Problem 25
-- The Fibonacci sequence is defined by the recurrence relation:

-- F(n) = F(n−1) + F(n−2), where F(1) = 1 and F(2) = 1.
-- Hence the first 12 terms will be:

-- F(1) = 1
-- F(2) = 1
-- F(3) = 2
-- F(4) = 3
-- F(5) = 5
-- F(6) = 8
-- F(7) = 13
-- F(8) = 21
-- F(9) = 34
-- F(10) = 55
-- F(11) = 89
-- F(12) = 144
-- The 12th term, F(12), is the first term to contain three digits.

-- What is the index of the first term in the Fibonacci sequence to contain 1000 digits?

numDigits :: Integer -> Int
numDigits = length . show

p025 = let Just (i, x) = find ((== 1000) . numDigits . snd) . zip [1..] $ genFibs 1 1 in i


-- Problem 26
-- A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

-- 1/2	= 	0.5
-- 1/3	= 	0.(3)
-- 1/4	= 	0.25
-- 1/5	= 	0.2
-- 1/6	= 	0.1(6)
-- 1/7	= 	0.(142857)
-- 1/8	= 	0.125
-- 1/9	= 	0.(1)
-- 1/10	= 	0.1
-- Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

-- Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

multiplicativeOrder :: Int -> Int -> Int
multiplicativeOrder _ 1 = 0
multiplicativeOrder a n = fromInteger $ order 1 (toInteger a) (toInteger n)
    where order k a' n' | mod a' n' == 1 = k
                        | otherwise      = order (k + 1) (a' * toInteger a) n'

makeCoprimeTo :: Int -> Int -> Int
makeCoprimeTo a b = reduce b (primeFactors a)
    where reduce 1 _  = 1
          reduce b [] = b
          reduce b (f:fs) | mod b f == 0 = reduce (div b f) (f:fs)
                          | otherwise    = reduce b fs

numReciprocalDigits :: Int -> Int
numReciprocalDigits = multiplicativeOrder 10 . makeCoprimeTo 10

p026 = fst . maximumBy (\(_, x) (_, y) -> compare x y) . zip [2..999] $ map numReciprocalDigits [2..999]


-- Problem 27
-- Euler discovered the remarkable quadratic formula:

-- n^2+n+41
-- It turns out that the formula will produce 40 primes for the consecutive integer values 0≤n≤39. However, when n=40,40^2+40+41=40^(40+1)+41 is divisible by 41,
-- and certainly when n=41,41^2+41+41 is clearly divisible by 41.

-- The incredible formula n^2−79n+1601 was discovered, which produces 80 primes for the consecutive values 0≤n≤79. The product of the coefficients, −79 and 1601, is −126479.

-- Considering quadratics of the form:

-- n^2+an+b, where |a|<1000 and |b|≤1000

-- where |n| is the modulus/absolute value of n
-- e.g. |11|=11 and |−4|=4
-- Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n=0.

numConsecutivePrimes :: (Int -> Int) -> Int
numConsecutivePrimes f = length . takeWhile isPrime . map f $ [0..]

genQuadratic :: Int -> Int -> Int -> Int -> Int
genQuadratic a b c x = a * (x^2) + b * x + c

p027 = uncurry (*) . snd . maximumBy (\(x,_) (y,_) -> compare x y) $ [ (numConsecutivePrimes (genQuadratic 1 a b), (a, b)) | a <- [(-999)..999], b <- [(-1000)..1000] ]


-- Problem 28
-- Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

-- 21 22 23 24 25
-- 20  7  8  9 10
-- 19  6  1  2 11
-- 18  5  4  3 12
-- 17 16 15 14 13

-- It can be verified that the sum of the numbers on the diagonals is 101.

-- What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

sumSpiralDiagonals :: Int -> Int
sumSpiralDiagonals dim = sum $ sDiags dim
    where sDiags 0 = []
          sDiags 1 = [1]
          sDiags n = let s = sDiags (n - 2)
                     in (reverse . tail . take 5 $ iterate (+ (n - 1)) (head s)) ++ s

p028 = sumSpiralDiagonals 1001