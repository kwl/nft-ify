require('babel-register');
require('babel-polyfill');
require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider-privkey');
const privateKeys = process.env.PRIVATE_KEYS || ""
const testnet = process.env.TESTNET;
const mainnet = process.env.MAINNET;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(
          privateKeys.split(','), // Array of account private keys
          `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`// Url to an Ethereum Node
        )
      },
      gas: 5000000,
      gasPrice: 25000000000,
      network_id: 3
    },
    testnet: {
      provider: () => new HDWalletProvider(privateKeys.split(','), testnet),
      // provider: () => new HDWalletProvider([privateKeys[0].replace("0x","")], testnet),
      network_id: 1666700000,
      skipDryRun: true,
    },
    mainnet: {
      provider: () => new HDWalletProvider(privateKeys.split(','), mainnet),
      network_id: 1666600000,
      skipDryRun: true,
    }
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      version: "0.8.1",
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}