var UserStore = artifacts.require("./UserStore.sol");
var VideoStore = artifacts.require("./VideoStore.sol");
var UserActions = artifacts.require("./UserActions.sol");

module.exports = function(deployer) {
  deployer.deploy(UserStore);
  deployer.deploy(VideoStore);
  deployer.deploy(UserActions);

};


