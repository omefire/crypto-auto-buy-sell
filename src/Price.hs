{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Price where 

import Network.HTTP.Req
import Control.Monad.IO.Class
import Data.ByteString.Char8
import Data.Aeson
import GHC.Generics

{- 
 https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT
 JSONResponse: {
    "symbol": "BTCUSDT",
    "price": "34604.88000000"
-}

type TickerName = String
data Ticker = Ticker { symbol :: TickerName, price :: Double }
    deriving (Generic, Show)

instance FromJSON Ticker where
    parseJSON (Object o) = do
        priceStr <- o .: "price"
        symbolStr <- o .: "symbol"
        return $ Ticker symbolStr (read priceStr :: Double)

instance ToJSON Ticker

-- TODO: What if an error occurs during JSON parsing?
-- TODO: What if Binance is down?
fetchPrice :: (MonadIO m) => TickerName -> m Double
fetchPrice ticker = runReq defaultHttpConfig $ do
    res <- req
             GET
             (https "api.binance.com" /: "api" /: "v3" /: "ticker" /: "price")
             NoReqBody
             bsResponse
             $ "symbol" =: ticker
    let bodyStr =  (responseBody res)
    -- liftIO $ print bodyStr
    let ebody = eitherDecodeStrict bodyStr :: Either String Ticker
    -- liftIO $ print ebody
    case ebody of 
        Left e -> error $ "Error while fetching and parsing the JSON price from Binance: " <> e -- TODO: What if an error occurs during JSON parsing?
        Right body -> return $ price body
