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
    
    event UserCreation(address indexed _userAddress, string _name, string _bio, uint _age, string _city );

    event UserUpdation(address indexed _userAddress, string _name, string _bio, uint _age, string _city );


    function addUser(string memory _name, string memory _bio, uint _age, string memory _city) public {
        require(checkUserExists(msg.sender) == false, "You are already signedUp");
        users[msg.sender] = User(_name,_bio,_age,_city,block.timestamp);
        emit UserCreation(msg.sender, _name, _bio, _age, _city);
    }

    function updateUser(string memory _name, string memory _bio, uint _age, string memory _city) public {
        users[msg.sender] = User({name:_name, bio:_bio, age: _age, city: _city, memberSince:users[msg.sender].memberSince});
        emit UserCreation(msg.sender, _name, _bio, _age, _city);
    }

    function getUserDetails(address _userAddress) public view returns (string memory, string memory, uint, string memory) {
        User memory user = users[_userAddress];
        return (user.name, user.bio, user.age, user.city);
    }

    function checkUserExists(address a) public view returns (bool) {
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
