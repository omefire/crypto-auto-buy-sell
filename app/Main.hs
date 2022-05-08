module Main where

import Price
import Pipes
import Control.Concurrent (threadDelay)

fetchPriceEveryNSecs :: (MonadIO m) => Int -> (TickerName -> m Double) -> Producer Double m ()
fetchPriceEveryNSecs microsecs fetchPrice = do
    price <- lift $ fetchPrice "BTCUSDT"
    yield price
    _ <- liftIO $ threadDelay microsecs
    fetchPriceEveryNSecs microsecs fetchPrice


consumePrices :: (MonadIO m) => Consumer Double m ()
consumePrices = do
    price <- await
    _ <- liftIO $ print $ "Price: " <> (show price)
    consumePrices


main :: IO ()
main = do
    runEffect $ (fetchPriceEveryNSecs 10000000 fetchPrice) >-> consumePrices