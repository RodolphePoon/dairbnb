module.exports = {
  compilers: {
    solc: {
      version: "0.8.14",
    },
  },
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
      from: "0x8e00Dbd213436dD3898216a07e76D79C3fE7Aa9E",
    },
    develop: {
      port: 8545,
    },
  },
};
