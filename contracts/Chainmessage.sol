// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Chainmessage is ERC721URIStorage {
    uint256 public tokenId;

    struct Message {
        string text;
        address author;
    }
    string public last_message;
    uint256 public messageid;
    address public current_address;
    uint256 public lock_date;
    bool public watchable = true;
    mapping(uint256 => Message) public messages;

    constructor() ERC721("Haiku", "Haiku") {}

    function safeMint() public {
        uint256 curr_tokenId = tokenId++;
        uint256 curr_messageId = messageid;

        require(curr_messageId >= 2, "not enough messages");

        Message storage message_2 = messages[curr_messageId - 3];
        Message storage message_1 = messages[curr_messageId - 2];
        Message storage message_0 = messages[curr_messageId - 1];
        string memory haiku = "";
        haiku = string(abi.encodePacked(haiku, message_2.text));
        haiku = string(abi.encodePacked(haiku, "\n"));
        haiku = string(abi.encodePacked(haiku, message_1.text));
        haiku = string(abi.encodePacked(haiku, "\n"));
        haiku = string(abi.encodePacked(haiku, message_0.text));

        _safeMint(msg.sender, curr_tokenId);
        _setTokenURI(curr_tokenId, haiku);
    }

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
        return last_message;
    }

    function createMessage(string memory text) public {
        //require(current_address == msg.sender, "current_address is not sender");

        Message memory message = Message(text, address(msg.sender));
        messages[messageid++] = message;
        last_message = text;
        current_address = 0x0000000000000000000000000000000000000000;
        lock_date = 0;
        watchable = true;
    }
}
