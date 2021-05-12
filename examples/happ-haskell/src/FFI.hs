{-# LANGUAGE ForeignFunctionInterface #-}

module FFI(
    acos,
    acosh,
    asin,
    asinh,
    atan,
    atanh,
    -- cbrt,
    -- ceil,
    cos,
    cosh,
    exp,
    -- fabs,
    floor,
    -- hypot,
    log,
    -- log10,
    -- pow,
    sin,
    sinh,
    sqrt,
    tan,
    tanh
) where

foreign import ccall "acos" c_acos :: Double -> Double
foreign import ccall "acosh" c_acosh :: Double -> Double
foreign import ccall "asin" c_asin :: Double -> Double
foreign import ccall "asinh" c_asinh :: Double -> Double
foreign import ccall "atan" c_atan :: Double -> Double
foreign import ccall "atanh" c_atanh :: Double -> Double
-- foreign import ccall "cbrt" c_cbrt :: Double -> Double
-- foreign import ccall "ceil" c_ceil :: Double -> Double
foreign import ccall "cos" c_cos :: Double -> Double
foreign import ccall "cosh" c_cosh :: Double -> Double
foreign import ccall "exp" c_exp :: Double -> Double
-- foreign import ccall "fabs" c_fabs :: Double -> Double
foreign import ccall "floor" c_floor :: Double -> Double -> Double
--foreign import ccall "hypot" c_hypot :: Double -> Double
foreign import ccall "log" c_log :: Double -> Double
-- foreign import ccall "log10" c_log10 :: Double -> Double
-- foreign import ccall "pow" c_pow :: Double -> Double -> Double
foreign import ccall "sin" c_sin :: Double -> Double
foreign import ccall "sinh" c_sinh :: Double -> Double
foreign import ccall "sqrt" c_sqrt :: Double -> Double
foreign import ccall "tan" c_tan :: Double -> Double
foreign import ccall "tanh" c_tanh :: Double -> Double
