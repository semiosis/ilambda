{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_QuickCheck (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [2,14,2] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/bin"
libdir     = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/lib"
dynlibdir  = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/lib"
datadir    = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/share"
libexecdir = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/libexec"
sysconfdir = "/home/shane/.cabal/store/ghc-8.10.4/QuickCheck-2.14.2-10dbdad459854a7377eacbce926f87917e02ec65584c8d08ecfef2108f3c499d/etc"

getBinDir     = catchIO (getEnv "QuickCheck_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "QuickCheck_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "QuickCheck_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "QuickCheck_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "QuickCheck_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "QuickCheck_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (last dir) = dir ++ fname
  | otherwise                  = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
