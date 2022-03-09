const HDWalletProvider = require('@truffle/hdwallet-provider');
const infuraKey = "0d2ce437ceee43b8a4d66d6d01e634c9";

const mnemonic = require("./secret.json").mnemonic;

module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    rinkeby: {
      provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/0d2ce437ceee43b8a4d66d6d01e634c9`),
      network_id: 4,
      gas: 5500000,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.12",
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
