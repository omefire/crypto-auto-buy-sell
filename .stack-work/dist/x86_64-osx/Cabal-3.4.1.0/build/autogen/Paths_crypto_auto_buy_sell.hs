{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_crypto_auto_buy_sell (
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

bindir     = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/bin"
libdir     = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/lib/x86_64-osx-ghc-9.0.2/crypto-auto-buy-sell-0.1.0.0-KBVNleQpQ9s9JUcCt4EnfQ"
dynlibdir  = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/share/x86_64-osx-ghc-9.0.2/crypto-auto-buy-sell-0.1.0.0"
libexecdir = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/libexec/x86_64-osx-ghc-9.0.2/crypto-auto-buy-sell-0.1.0.0"
sysconfdir = "/Users/omefire/Projects/crypto-auto-buy-sell/.stack-work/install/x86_64-osx/15068a339bb325760338bde71cc6f7cdad8127b984bb387351946bff0e4c3338/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "crypto_auto_buy_sell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "crypto_auto_buy_sell_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "crypto_auto_buy_sell_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "crypto_auto_buy_sell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "crypto_auto_buy_sell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "crypto_auto_buy_sell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
