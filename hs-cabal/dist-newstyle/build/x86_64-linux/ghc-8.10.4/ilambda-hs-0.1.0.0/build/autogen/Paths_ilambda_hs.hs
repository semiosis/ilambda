{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_ilambda_hs (
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
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/shane/.cabal/bin"
libdir     = "/home/shane/.cabal/lib/x86_64-linux-ghc-8.10.4/ilambda-hs-0.1.0.0-inplace"
dynlibdir  = "/home/shane/.cabal/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/shane/.cabal/share/x86_64-linux-ghc-8.10.4/ilambda-hs-0.1.0.0"
libexecdir = "/home/shane/.cabal/libexec/x86_64-linux-ghc-8.10.4/ilambda-hs-0.1.0.0"
sysconfdir = "/home/shane/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ilambda_hs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ilambda_hs_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ilambda_hs_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ilambda_hs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ilambda_hs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ilambda_hs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
