pragma solidity ^0.8.18;
import "./UserStore.sol";
import "./VideoStore.sol";
contract UserActions is UserStore, VideoStore {

    event UserCreation(address indexed _userAddress, string _name, string _bio, uint _age, string _city );

    event UserUpdation(address indexed _userAddress, string _name, string _bio, uint _age, string _city );

    event addVideoEvent(string _name, string _description, uint _publishedOn, string _IPFSHash,string uniqueId);

    function addUser(string memory _name, string memory _bio, uint _age, string memory _city) public {
        _addUser(_name,_bio,_age,_city);
        emit UserCreation(msg.sender, _name, _bio, _age, _city);
    }

    function updateUser(string memory _name, string memory _bio, uint _age, string memory _city) public {
        _updateUser(_name, _bio, _age, _city);
        emit UserUpdation(msg.sender, _name, _bio, _age, _city);
    }

    function getUserDetails(address _userAddress) public view returns (string memory, string memory, uint, string memory)  {
        return _getUserDetails(_userAddress);
    }

    function addVideo(string memory _name, string memory _description, string memory _IPFSHash) public {
        require(checkUserExists(msg.sender) == true,"Please signup first");
        string memory uniqueId = _addVideo( _name, _description, _IPFSHash);
        emit addVideoEvent(_name, _description, block.timestamp, _IPFSHash, uniqueId);
    }

}