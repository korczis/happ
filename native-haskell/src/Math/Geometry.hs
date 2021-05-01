module Math.Geometry(
        areaCircle,
        areaRectangle,
        areaSquare
       ) where

areaCircle :: Floating t => t -> t
areaCircle r = r^2 * pi

areaRectangle :: Num t => t -> t -> t
areaRectangle a b = a * b

areaSquare :: Num t => t -> t
areaSquare a = a * a