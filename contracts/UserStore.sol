pragma solidity ^0.8.18;
contract UserStore {
    struct User {
        string name;
        string bio;
        uint age;
        string city;
        uint memberSince;
    }

    mapping(address => User) public users;
    
    


    function _addUser(string memory _name, string memory _bio, uint _age, string memory _city) internal {
        require(checkUserExists(msg.sender) == false, "You are already signedUp");
        users[msg.sender] = User(_name,_bio,_age,_city,block.timestamp);
        
    }

    function _updateUser(string memory _name, string memory _bio, uint _age, string memory _city) internal {
        users[msg.sender] = User({name:_name, bio:_bio, age: _age, city: _city, memberSince:users[msg.sender].memberSince});
    }

    function _getUserDetails(address _userAddress) internal view returns (string memory, string memory, uint, string memory)  {
        User memory user = users[_userAddress];
        return (user.name, user.bio, user.age, user.city);
    }

    function checkUserExists(address a) internal view returns (bool) {
        if(users[a].memberSince == 0)
        {
            return false;
        }
        else
        {
            return true;
        }
  }
}
