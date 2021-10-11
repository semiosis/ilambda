{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_hs_simple (
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

bindir     = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/bin"
libdir     = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/lib/x86_64-linux-ghc-8.10.7/hs-simple-0.1.0.0-2s7hDTc7iHt810D8LQwyCs-hs-simple"
dynlibdir  = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/lib/x86_64-linux-ghc-8.10.7"
datadir    = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/share/x86_64-linux-ghc-8.10.7/hs-simple-0.1.0.0"
libexecdir = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/libexec/x86_64-linux-ghc-8.10.7/hs-simple-0.1.0.0"
sysconfdir = "/home/shane/var/smulliga/source/git/semiosis/ilambda/hs/.stack-work/install/x86_64-linux-tinfo6/208cfab785be3114f86773f85f5e75874ff89fc113edbdd28c7bd326a0ecaf2a/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hs_simple_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hs_simple_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hs_simple_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hs_simple_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hs_simple_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hs_simple_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
