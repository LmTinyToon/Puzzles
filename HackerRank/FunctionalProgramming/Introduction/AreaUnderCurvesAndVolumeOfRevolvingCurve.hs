﻿import Text.Printf (printf)

--  Integro functions
step :: Double
step = 0.001

steps_count :: Int -> Int
steps_count s = round $ (fromIntegral s) / step

integrate :: (Double -> Double) -> Double -> Int -> Double
integrate f a 0 = 0
integrate f a i = (f a) * step + (integrate f (a + step) (i - 1))

--  Generation of function
gen_func :: [Double] -> [Double] -> (Double -> Double)
gen_func a b = \x -> sum (zipWith (*) a (map (x**) b))

-- This function should return a list [area, volume].
solve :: Int -> Int -> [Int] -> [Int] -> [Double]
solve l r a b = [area, volume] where 
                    f = gen_func (map fromIntegral a) (map fromIntegral b)
                    area = integrate f (fromIntegral l) (steps_count (r-l))
                    volume = pi * integrate (\x -> (f x) * (f x)) (fromIntegral l) (steps_count (r-l))

--Input/Output.
main :: IO ()
main = getContents >>= mapM_ (printf "%.1f\n"). (\[a, b, [l, r]] -> solve l r a b). map (map read. words). lines
