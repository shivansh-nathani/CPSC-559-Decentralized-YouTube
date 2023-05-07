pragma solidity ^0.8.18;
import "@openzeppelin/contracts/utils/Strings.sol";
contract VideoStore  {

   
    struct Video {
        string name;
        string description;
        uint publishedOn;
        string IPFSHash;
        string uniqueId;
    }

    struct Comment {
        string comment;
        address userAddress;
        uint timestamp;
    }

    mapping(string => Comment[]) public comment;
    mapping(address=> Video[]) public userToVideo;
    function _addVideo(string memory _name, string memory _description, string memory _IPFSHash) internal returns (string memory) {
        string memory uniqueId = string.concat(Strings.toHexString(uint256(uint160(msg.sender)), 20),_IPFSHash,Strings.toHexString(block.timestamp));
        userToVideo[msg.sender].push(Video(_name,_description,block.timestamp,_IPFSHash,uniqueId));
        return uniqueId;
    }

    function _getVideoIndex(address _add, string memory _IPFSHash, uint _timestamp) internal view returns (int){
        Video[] memory videoList = userToVideo[_add];
        string memory uniqueId = string.concat(Strings.toHexString(uint256(uint160(_add)), 20),_IPFSHash,Strings.toHexString(_timestamp));
        for (uint i=0; i<videoList.length; i++) {
            if(keccak256(abi.encodePacked(videoList[i].uniqueId)) == keccak256(abi.encodePacked(uniqueId)))
            {
                return int(i);
            }
            i++;
        }
        return -1;
    }

    function _updateVideo(string memory _name, string memory _description, string memory _IPFSHash,uint _timestamp) internal {
        int index = _getVideoIndex(msg.sender, _IPFSHash, _timestamp);
        require( index > -1,"You are not authorized to update this!");
        userToVideo[msg.sender][uint(index)] = Video({name:_name, description:_description, publishedOn: userToVideo[msg.sender][uint(index)].publishedOn, IPFSHash:userToVideo[msg.sender][uint(index)].IPFSHash,uniqueId:userToVideo[msg.sender][uint(index)].uniqueId});
    }

    function _addComment(string memory _unqiueId, string _comment, address _userAddress) internal {
        comment[_unqiueId].push(Comment(_comment,_userAddress,block.timestamp));
    }
}
