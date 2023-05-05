pragma solidity ^0.8.18;
import "@openzeppelin/contracts/utils/Strings.sol";
contract VideoStore {
    struct Video {
        string name;
        string description;
        uint publishedOn;
        string IPFSHash;
        string uniqueId;
    }

    event addVideoEvent(string _name, string _description, uint _publishedOn, string _IPFSHash,string uniqueId);


    mapping(address=> Video[]) public userToVideo;
    function addVideo(string memory _name, string memory _description, string memory _IPFSHash) public {
        string memory uniqueId = string.concat(Strings.toHexString(uint256(uint160(msg.sender)), 20),_IPFSHash,Strings.toHexString(block.timestamp));
        userToVideo[msg.sender].push(Video(_name,_description,block.timestamp,_IPFSHash,uniqueId));
        emit addVideoEvent(_name, _description, block.timestamp, _IPFSHash, uniqueId);
    }

    function getVideoIndex(address _add, string memory _IPFSHash, uint _timestamp) public view returns (int){
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

    function updateVideo(string memory _name, string memory _description, string memory _IPFSHash,uint _timestamp) public {
        int index = getVideoIndex(msg.sender, _IPFSHash, _timestamp);
        require( index > -1,"You are not authorized to update this!");
        userToVideo[msg.sender][uint(index)] = Video({name:_name, description:_description, publishedOn: userToVideo[msg.sender][uint(index)].publishedOn, IPFSHash:userToVideo[msg.sender][uint(index)].IPFSHash,uniqueId:userToVideo[msg.sender][uint(index)].uniqueId});
    }
}
