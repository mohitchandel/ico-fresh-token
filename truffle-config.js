const HDWalletProvider = require('@truffle/hdwallet-provider');
const infuraKey = "0d2ce437ceee43b8a4d66d6d01e634c9";

const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    },
    rinkeby: {
      privider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
      network_id: 4,
      gas: 5500000,
      gasPrice: 5000000000
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.5.0",
      optimizer: {
        enabled: false,
        runs: 200,
      },
    },
  },

  db: {
    enabled: false,
  },
};
