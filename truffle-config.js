module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
      from: "0x2B182e6DD52A2F86ef8f3537F59A4e9064dfC63f",
    },
    develop: {
      port: 8545,
    },
  },
};
