var UserStore = artifacts.require("./UserStore.sol");
var VideoStore = artifacts.require("./VideoStore.sol");

module.exports = function(deployer) {
  deployer.deploy(UserStore);
  deployer.deploy(VideoStore);

};


