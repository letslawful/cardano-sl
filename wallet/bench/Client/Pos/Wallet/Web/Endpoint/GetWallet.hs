-- | Run 'GetWallets' client.

module Client.Pos.Wallet.Web.Endpoint.GetWallet
    ( getWalletIO
    ) where

import           Universum

import           Client.Pos.Wallet.Web.Api  (getWallet)
import           Client.Pos.Wallet.Web.Run  (runEndpointClient)
import           Bench.Pos.Wallet.Types     (CompleteConfig (..), Wallet (..))
import           Bench.Pos.Wallet.Random    (pickRandomWalletFrom)

-- | Run 'GetWallet' client. As a result we will get a particular wallet.
getWalletIO :: CompleteConfig -> IO ()
getWalletIO conf@CompleteConfig {..} = do
    Wallet anId _ <- pickRandomWalletFrom walletsConfig
    runEndpointClient conf (getWallet anId) >>= \case
        Left problem -> putText $ "Cannot obtain wallet information: " <> problem
        Right _ -> return ()
