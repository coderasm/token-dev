import { HardhatUserConfig} from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "hardhat-deploy-ethers";
import "hardhat-deploy";
import "@symfoni/hardhat-react";
import "hardhat-typechain";
import "@typechain/ethers-v5";
import * as fs from "fs";

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
const secret = fs.readFileSync("./secrets/.secret-testnet").toString().trim();
//const secret = fs.readFileSync("./secrets/.secret-mainnet").toString().trim();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const config: HardhatUserConfig = {
  react: {
    providerPriority: ["web3modal", "hardhat"],
  },
  networks: {
    hardhat: {
      forking: {
        url: "https://rpc.testnet.fantom.network/"
        //url: "https://data-seed-prebsc-1-s1.binance.org:8545"
        //url: "https://bsc-dataseed.binance.org/"
      },
      chainId: 1337,
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    },
    // hardhat: {
    //   accounts: [
    //     {
    //       balance: "10000000000000000000000",
    //       privateKey:
    //         "0xe87d780e4c31c953a68aef2763df56599c9cfe73df4740fc24c2d0f5acd21bae",
    //     },
    //   ],
    // },
    localhost: {
      url: "http://127.0.0.1:8545",
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    },
    fantomTestnet: {
      url: "https://rpc.testnet.fantom.network/",
      chainId: 4002,
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    },
    fantomMainnet: {
      url: "https://rpc.ftm.tools/",
      chainId: 250,
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    },
    bscTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    },
    bscMainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      inject: false, // optional. If true, it will EXPOSE your mnemonic in your frontend code. Then it would be available as an "in-page browser wallet" / signer which can sign without confirmation.
      accounts: {
        mnemonic: secret, // test test test test test test test test test test test junk
        initialIndex: 0
      },
    }
  },
  solidity: {
    compilers: [
      {
        version: "0.8.5",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.7.3",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.5.16",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      }
    ],
  },
};
export default config;
