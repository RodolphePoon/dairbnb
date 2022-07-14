pragma solidity ^0.5.16;

contract Chainmessage {
    string public last_message;
    uint256 public messageid;
    address public current_address;
    uint256 public lock_date;
    bool public watchable = true;

    mapping(uint256 => string) public messages;

    function unlock() public {
        if (lock_date > 0 && block.timestamp - lock_date > 30) {
            current_address = msg.sender;
            lock_date = block.timestamp;
        } else {
            require(
                current_address == 0x0000000000000000000000000000000000000000,
                "current_address not null try again in 30 seconds"
            );
            current_address = msg.sender;
            lock_date = block.timestamp;
        }
    }

    event print_message(address sender, string last_message);

    function get_last_message() public returns (string memory) {
        require(current_address == msg.sender, "current_address is not sender");
        require(watchable == true, "cannot watch");
        watchable = false;
        emit print_message(msg.sender, last_message);
    }

    function createMessage(string memory text) public {
        require(current_address == msg.sender, "current_address is not sender");
        messages[messageid++] = text;
        last_message = text;
        current_address = 0x0000000000000000000000000000000000000000;
        lock_date = 0;
        watchable = true;
    }
}
