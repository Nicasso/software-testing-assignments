module Lab2 where
 
import Data.List
import System.Random

data Shape = NoTriangle | Equilateral 
            | Isosceles | Rectangular | Other deriving (Eq,Show)

triangle :: Integer -> Integer -> Integer -> Shape
triangle  a b c | (a + b <= c) || (b + c <= a) || (c + a <= b) = NoTriangle
                | (a == b) && (b == c) = Equilateral
                | (a == b) || (b == c) || (a == c) = Isosceles
                | (a^2 + b^2 == c^2) || (a^2 + c^2 == b^2) || (b^2 + c^2 == a^2) = Rectangular
                | otherwise = Other

-- ANDRE T. VERSION
triangleA :: Integer -> Integer -> Integer -> Shape
triangleA x y z  | ((x + y <= z) || (x + z <= y) || (z + y <= x)) = NoTriangle
         | (x == y) && (x == z) = Equilateral 
         | (((x == y) && (x /= z)) || ((x == z) && (x /= y)) || ((y == z) && (y /= x))) = Isosceles 
         | (x^2 + y^2 == z^2) || (z^2 + y^2 == x^2) || (x^2 + z^2 == y^2) = Rectangular   
         | otherwise = Other

isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation a b = elem a (permutations b)

-- IBAN
iban :: String -> Bool
iban x = (validateCheckDigit(convertIntoNumerics(moveFourCharacters(trim(x)))))

trim :: [Char] -> [Char]
trim [] = []
trim (x:xs) | isLetter x || isDigit x = [x] ++ trim xs
            | otherwise = trim xs

moveFourCharacters :: [Char] -> [Char]
moveFourCharacters x = (drop 4 x) ++ (take 4 x)

convertIntoNumerics :: [Char] -> [Char]
convertIntoNumerics [] = []
convertIntoNumerics (x:xs) | isLetter x = show(ord x - 55) ++ convertIntoNumerics xs
                           | otherwise = [x] ++ convertIntoNumerics xs
                           
validateCheckDigit :: [Char] -> Bool
validateCheckDigit x = ((read x) `mod` 97) == 1