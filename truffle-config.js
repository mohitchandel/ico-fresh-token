const HDWalletProvider = require('@truffle/hdwallet-provider');
const infuraKey = "fj4jll3k.....";

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
      privider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/0d2ce437ceee43b8a4d66d6d01e634c9`),
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

  // Truffle DB is currently disabled by default; to enable it, change enabled: false to enabled: true
  //
  // Note: if you migrated your contracts prior to enabling this field in your Truffle project and want
  // those previously migrated contracts available in the .db directory, you will need to run the following:
  // $ truffle migrate --reset --compile-all

  db: {
    enabled: false,
  },
};
